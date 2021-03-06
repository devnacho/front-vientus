module Form.State exposing (init, update, subscriptions)

import Form.Types exposing (..)
import Form.Rest
import Utils.ErrorView exposing (error)
import String exposing (isEmpty)
import Regex
import Translation.Utils exposing (..)
import App.Ports as Ports

init : ( Model, Cmd Msg )
init =
  ( initialModel
  , Cmd.batch initialCommands
  )

subscriptions model =
  Sub.batch
    [ Ports.selectSpot SelectSpot
    ]

initialModel : Model
initialModel =
  { email = ""
  , windSpeed = "11"
  , windDirections = []
  , countries = []
  , selectedCountry = Nothing
  , regions = []
  , selectedRegion = Nothing
  , spots = []
  , selectedSpot = Nothing
  , errors = initialErrors
  , status = Clean
  , language = English
  , daysVisible = False
  , days = allDaysOfWeek
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


initialCommands : List (Cmd Msg)
initialCommands =
  [ Form.Rest.getCountries
  ]


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
  case action of
    ToggleDaysVisibility ->
      { model
        | daysVisible = not model.daysVisible
      } ! []

    ToggleDay day ->
      let
        toggledList =
          if List.member day model.days then
            List.filter (\d -> d /= day) model.days
          else
            day :: model.days
        newModel =
          { model
            | days = toggledList
          }
      in
        validateNewModel newModel ! []

    SetCountries countries ->
      ( { model
          | countries = Maybe.withDefault [] countries
        }
      , Cmd.none
      )

    HttpFail _ ->
      ( model, Cmd.none )

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
            Cmd.none
          else
            Cmd.batch
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
      , Cmd.none
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
            Cmd.none
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
      let
        justSpots = Maybe.withDefault [] spots
      in
        ( { model
            | spots = justSpots
          }
        , Ports.setMarkers justSpots
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

        selectedInfo =
          { prevSelectedSpot = model.selectedSpot
          , newSelectedSpot = selectedSpot
          }

        newModel =
          { model
            | selectedSpot = selectedSpot
          }

        cmd =
          if selectedInfo.newSelectedSpot == selectedInfo.prevSelectedSpot then
            Cmd.none
          else
            Ports.setSelectedMarker selectedInfo
      in
        ( validateNewModel newModel
        , cmd
        )

    SetEmail str ->
      let
        newModel =
          { model
            | email = str
          }
      in
        ( validateNewModel newModel
        , Cmd.none
        )

    SetWindSpeed str ->
      let
        newModel =
          { model
            | windSpeed = str
          }
      in
        ( validateNewModel newModel
        , Cmd.none
        )

    ToggleWindDirection direction ->
      let
        toggledList =
          if List.member direction model.windDirections then
            List.filter (\d -> d /= direction) model.windDirections
          else
            direction :: model.windDirections
        newModel = { model | windDirections = toggledList }
      in
        validateNewModel newModel ! []

    SubmitAlert ->
      let
        errors =
          validate model

        submitModel =
          { email = model.email
          , windSpeed = model.windSpeed
          , windDirections = model.windDirections
          , availableDays = model.days
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
            Cmd.none

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
      , Cmd.none
      )

    SubmitFailure ->
      ( { model
          | status = Failure
        }
      , Cmd.none
      )

    ChangeLanguage language ->
      ( { model
          | language = language
        }
      , Cmd.none
      )

    ShareVientus network ->
      ( model , Ports.share network )


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
      if List.isEmpty model.days then
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
