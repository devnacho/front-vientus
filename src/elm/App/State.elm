module App.State (initialModel, update) where

import Effects exposing (Effects)
import App.Types exposing (..)
import WindDirection.State


initialModel : Model
initialModel =
  { email = ""
  , windSpeed = "11"
  , windDirections = WindDirection.State.initialModel
  , availableDays = [ Mon, Tue, Wed, Thu, Fri, Sat, Sun ]
  , daysVisible = False
  }



-- UPDATE


update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

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

    ToggleDaysVisibility ->
      ( { model
          | daysVisible = not model.daysVisible
        }
      , Effects.none
      )

    ToggleDay day ->
      let
        toggledList =
          if List.member day model.availableDays then
            List.filter (\d -> d /= day) model.availableDays
          else
            day :: model.availableDays
      in
        ( { model
            | availableDays = toggledList
          }
        , Effects.none
        )
