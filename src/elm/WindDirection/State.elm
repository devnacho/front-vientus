module WindDirection.State (initialModel, update) where

import WindDirection.Types exposing (..)


initialModel : Model
initialModel =
  []


update : Action -> Model -> Model
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
        toggledList
