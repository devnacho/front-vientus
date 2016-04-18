module WindDirection.State (initialModel, update) where

import Effects exposing (Effects)
import WindDirection.Types exposing (..)


initialModel : Model
initialModel =
  [ N, NE ]


update action model =
  case action of
    ToggleWindDirection direction ->
      let
        toggledList =
          if List.member direction model then
            List.filter (\d -> d /= direction) model
          else
            direction :: model
      in
        ( toggledList
        , Effects.none
        )