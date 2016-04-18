module AvailableDays.State (initialModel, update) where

import Effects exposing (Effects)
import AvailableDays.Types exposing (..)


initialModel : Model
initialModel =
  { visible = False
  , days = AvailableDays.Types.allDaysOfWeek
  }


update action model =
  case action of
    ToggleDaysVisibility ->
      ( { model
          | visible = not model.visible
        }
      , Effects.none
      )

    ToggleDay day ->
      let
        toggledList =
          if List.member day model.days then
            List.filter (\d -> d /= day) model.days
          else
            day :: model.days
      in
        ( { model
            | days = toggledList
          }
        , Effects.none
        )
