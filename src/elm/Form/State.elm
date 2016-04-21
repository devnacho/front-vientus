module Form.State (init, update) where

import Effects exposing (Effects)
import Form.Types exposing (..)
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
  }


initialEffects : List ( Effects Action )
initialEffects =
  [ Effects.none 
  ]


-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

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
