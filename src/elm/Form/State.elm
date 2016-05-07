module Form.State (init, update) where

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
  { email = ""
  , windSpeed = ""
  , windDirections = ""
  , availableDays = ""
  , selectedCountry = ""
  , selectedSpot = ""
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
      in
        ( { model
            | selectedCountry = selectedCountry
            , selectedRegion = Nothing
            , regions = []
            , selectedSpot = Nothing
            , spots = []
          }
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
      in
        ( { model
            | selectedSpot = selectedSpot
          }
        , Effects.none
        )

    SetEmail str ->
      ( { model
          | email = str
        }
      , Effects.none
      )

    SetWindSpeed str ->
      ( { model
          | windSpeed = str
        }
      , Effects.none
      )

    SubmitAlert ->
      let
        errorsTuple =
          getErrors model

        errors =
          fst errorsTuple

        hasErrors =
          snd errorsTuple

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
          if hasErrors == False then
            Form.Rest.submitAlert submitModel
          else
            Effects.none

        status =
          if hasErrors == False then
            Submitting
          else
            Clean
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
      ( { model
          | availableDays = AvailableDays.State.update action model.availableDays
        }
      , Effects.none
      )

    WindDirection action ->
      ( { model
          | windDirections = WindDirection.State.update action model.windDirections
        }
      , Effects.none
      )


getErrors : Model -> ( Errors, Bool )
getErrors model =
  let
    errors =
      { email =
          if not (isValidEmail model.email) then
            i18n model.language EmailErrorText
          else
            ""
      , windSpeed =
          if model.windSpeed == "" then
            i18n model.language WindSpeedErrorText1
          else if not (isPositiveNumber model.windSpeed) then
            i18n model.language WindSpeedErrorText2
          else
            ""
      , windDirections =
          if List.isEmpty model.windDirections then
            i18n model.language WindDirErrorText
          else
            ""
      , availableDays =
          if List.isEmpty model.availableDays.days then
            i18n model.language DaysErrorText
          else
            ""
      , selectedCountry =
          case model.selectedCountry of
            Nothing ->
              i18n model.language CountryErrorText

            Just _ ->
              ""
      , selectedSpot =
          case model.selectedSpot of
            Nothing ->
              i18n model.language SpotErrorText

            Just _ ->
              ""
      }

    hasErrors =
      not
        <| noErrors errors.email
        && noErrors errors.windSpeed
        && noErrors errors.windDirections
        && noErrors errors.availableDays
        && noErrors errors.selectedCountry
        && noErrors errors.selectedSpot
  in
    ( errors
    , hasErrors
    )


noErrors : String -> Bool
noErrors =
  isEmpty



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
