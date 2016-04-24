module Form.State (init, update) where

import Effects exposing (Effects)
import Form.Types exposing (..)
import Form.Rest
import WindDirection.State
import AvailableDays.State


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

    SubmitAlert ->
      let
        submitModel = 
          { email = model.email
          , windSpeed = model.windSpeed
          , windDirections = model.windDirections
          , availableDays = model.availableDays
          , selectedSpot = Maybe.withDefault (Spot "" "" 0 0 ) model.selectedSpot
          }
      in
        ( model, Form.Rest.submitAlert submitModel )

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
