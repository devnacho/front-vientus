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
      let
        _ =
          Debug.log "COUNTRIES" countries

        {-
        _ =
          case countriesList of
            Just Countries ->
              Debug.log "First Country" ( List.head countriesList )
            Nothing ->
              Debug.log "No countries" ()
        -}
      in
        ( { model
            | countries = Maybe.withDefault [] countries
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
