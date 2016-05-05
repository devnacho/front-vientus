module Form.State (init, update) where

import Effects exposing (Effects)
import Form.Types exposing (..)
import Form.Rest
import Utils.ErrorView exposing (error)
import WindDirection.State
import AvailableDays.State
import String exposing (isEmpty)
import Regex


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
    NoOp ->
      ( model, Effects.none )

    SubmitSuccess ->
      let
        _ = Debug.log "TODO BIEN" ""
      in
        ( model, Effects.none )

    SubmitFailure ->
      let
        _ = Debug.log "TODO Mal" ""
      in
        ( model, Effects.none )

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
                Nothing -> ""
                Just spot -> spot.id
          }

        command =
          if hasErrors == False then
            Form.Rest.submitAlert submitModel
          else
            Effects.none
      in
        ( { model
            | errors = errors
          }
        , command
        )

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


getErrors : Model -> ( Errors, Bool )
getErrors model =
  let
    errors =
      { email =
          if not (isValidEmail model.email) then
            "Please enter a valid email"
          else
            ""
      , windSpeed =
          if model.windSpeed == "" then
            "Please enter a number in knots as the minimum speed"
          else if not( isPositiveNumber model.windSpeed ) then
            "Please enter a positive number"
          else
            ""
      , windDirections = 
        if List.isEmpty model.windDirections then
          "Please select at least one wind direction"
        else 
          ""
      , availableDays = 
        if List.isEmpty model.availableDays.days then
          "Please select at least one day"
        else 
          ""
      , selectedCountry = 
        case model.selectedCountry of 
          Nothing -> "Please select a country"
          Just _ -> ""
      , selectedSpot = 
        case model.selectedSpot of 
          Nothing -> "Please select a spot"
          Just _ -> ""
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
