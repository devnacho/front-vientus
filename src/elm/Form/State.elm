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
            Form.Rest.getCountrySpots id
      in
        ( { model
            | selectedCountry = selectedCountry
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
