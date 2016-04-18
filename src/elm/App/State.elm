module App.State (initialModel, update) where

import Effects exposing (Effects)
import App.Types exposing (..)
import WindDirection.State
import AvailableDays.State


initialModel : Model
initialModel =
  { email = ""
  , windSpeed = "11"
  , windDirections = WindDirection.State.initialModel
  , availableDays = AvailableDays.State.initialModel
  }



-- UPDATE


update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    AvailableDays action ->
      let
        ( childModel, childEffects ) =
          AvailableDays.State.update action model.availableDays
      in
        ( { model
            | availableDays = childModel
          }
        , Effects.map AvailableDays childEffects
        )

    WindDirection action ->
      let
        ( childModel, childEffects ) =
          WindDirection.State.update action model.windDirections
      in
        ( { model
            | windDirections = childModel
          }
        , Effects.map WindDirection childEffects
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

