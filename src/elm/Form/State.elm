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
      in
        ( { model
            | selectedCountry = selectedCountry
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
