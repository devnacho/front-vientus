module Form.State exposing (init, update)

import Effects exposing (Effects)
import Form.Types exposing (..)
import Form.Rest
import Utils.ErrorView exposing (error)
import WindDirection.State
import AvailableDays.State
import String exposing (isEmpty)
import Regex
import Translation.Utils exposing (..)


init : ( Model, Effects Action )
init =
  ( initialModel
  , Effects.batch initialEffects
  )


initialModel : Model
initialModel =
  { email = ""
  , windSpeed = "11"
  , windDirections = WindDirection.State.initialModel
  , availableDays = AvailableDays.State.initialModel
  , countries = []
  , selectedCountry = Nothing
  , regions = []
  , selectedRegion = Nothing
  , spots = []
  , selectedSpot = Nothing
  , errors = initialErrors
  , status = Clean
  , language = English
  }


initialErrors : Errors
initialErrors =
  { email = EmptyError
  , windSpeed = EmptyError
  , windDirections = EmptyError
  , availableDays = EmptyError
  , selectedCountry = EmptyError
  , selectedSpot = EmptyError
  }


initialEffects : List (Effects Action)
initialEffects =
  [ Form.Rest.getCountries
  ]


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    SetCountries countries ->
      ( { model
          | countries = Maybe.withDefault [] countries
        }
      , Effects.none
      )

    SelectCountry id ->
      let
        filteredCountries =
          List.filter (\country -> country.id == id) model.countries

        selectedCountry =
          if (List.isEmpty filteredCountries) then
            Nothing
          else
            List.head filteredCountries

        effect =
          if (List.isEmpty filteredCountries) then
            Effects.none
          else
            Effects.batch
              [ Form.Rest.getRegions id
              , Form.Rest.getCountrySpots id
              ]

        newModel =
          { model
            | selectedCountry = selectedCountry
            , selectedRegion = Nothing
            , regions = []
            , selectedSpot = Nothing
            , spots = []
          }
      in
        ( validateNewModel newModel
        , effect
        )

    SetRegions regions ->
      ( { model
          | regions = Maybe.withDefault [] regions
        }
      , Effects.none
      )

    SelectRegion id ->
      let
        filteredRegions =
          List.filter (\region -> region.id == id) model.regions

        selectedRegion =
          if (List.isEmpty filteredRegions) then
            Nothing
          else
            List.head filteredRegions

        effect =
          if (List.isEmpty filteredRegions) then
            Effects.none
          else
            Form.Rest.getRegionSpots id
      in
        ( { model
            | selectedRegion = selectedRegion
            , selectedSpot = Nothing
            , spots = []
          }
        , effect
        )

    SetSpots spots ->
      ( { model
          | spots = Maybe.withDefault [] spots
        }
      , Effects.none
      )

    SelectSpot id ->
      let
        filteredSpots =
          List.filter (\spot -> spot.id == id) model.spots

        selectedSpot =
          if (List.isEmpty filteredSpots) then
            Nothing
          else
            List.head filteredSpots

        newModel =
          { model
            | selectedSpot = selectedSpot
          }
      in
        ( validateNewModel newModel
        , Effects.none
        )

    SetEmail str ->
      let
        newModel =
          { model
            | email = str
          }
      in
        ( validateNewModel newModel
        , Effects.none
        )

    SetWindSpeed str ->
      let
        newModel =
          { model
            | windSpeed = str
          }
      in
        ( validateNewModel newModel
        , Effects.none
        )

    SubmitAlert ->
      let
        errors =
          validate model

        submitModel =
          { email = model.email
          , windSpeed = model.windSpeed
          , windDirections = model.windDirections
          , availableDays = model.availableDays
          , selectedSpotId =
              case model.selectedSpot of
                Nothing ->
                  ""

                Just spot ->
                  spot.id
          }

        command =
          if (hasErrors errors) == False then
            Form.Rest.submitAlert submitModel
          else
            Effects.none

        status =
          if (hasErrors errors) == False then
            Submitting
          else
            Dirty
      in
        ( { model
            | errors = errors
            , status = status
          }
        , command
        )

    SubmitSuccess ->
      ( { model
          | status = Success
        }
      , Effects.none
      )

    SubmitFailure ->
      ( { model
          | status = Failure
        }
      , Effects.none
      )

    ChangeLanguage language ->
      ( { model
          | language = language
        }
      , Effects.none
      )

    AvailableDays action ->
      let
        newModel =
          { model
            | availableDays = AvailableDays.State.update action model.availableDays
          }
      in
        ( validateNewModel newModel
        , Effects.none
        )

    WindDirection action ->
      let
        newModel =
          { model
            | windDirections = WindDirection.State.update action model.windDirections
          }
      in
        ( validateNewModel newModel
        , Effects.none
        )


validateNewModel : Model -> Model
validateNewModel newModel =
  { newModel
    | errors =
        if newModel.status /= Clean then
          validate newModel
        else
          newModel.errors
  }


validate : Model -> Errors
validate model =
  { email =
      if not (isValidEmail model.email) then
        EmailErrorText
      else
        EmptyError
  , windSpeed =
      if model.windSpeed == "" then
        WindSpeedErrorText1
      else if not (isPositiveNumber model.windSpeed) then
        WindSpeedErrorText2
      else
        EmptyError
  , windDirections =
      if List.isEmpty model.windDirections then
        WindDirErrorText
      else
        EmptyError
  , availableDays =
      if List.isEmpty model.availableDays.days then
        DaysErrorText
      else
        EmptyError
  , selectedCountry =
      case model.selectedCountry of
        Nothing ->
          CountryErrorText

        Just _ ->
          EmptyError
  , selectedSpot =
      case model.selectedSpot of
        Nothing ->
          SpotErrorText

        Just _ ->
          EmptyError
  }


hasErrors : Errors -> Bool
hasErrors errors =
  not
    <| EmptyError == errors.email
    && EmptyError == errors.windSpeed
    && EmptyError == errors.windDirections
    && EmptyError == errors.availableDays
    && EmptyError == errors.selectedCountry
    && EmptyError == errors.selectedSpot




-- TODO MOVE THIS TO UTILS MODULE


isPositiveNumber : String -> Bool
isPositiveNumber subject =
  case String.toInt subject of
    Ok number ->
      if number > 0 then
        True
      else
        False

    Err _ ->
      False


isValidEmail : String -> Bool
isValidEmail =
  let
    validEmail =
      Regex.regex "^[a-zA-Z0-9.!#$%&'*+\\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        |> Regex.caseInsensitive
  in
    Regex.contains validEmail
