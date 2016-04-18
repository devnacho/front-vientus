module App.State (initialModel, update) where

import Effects exposing (Effects)

import App.Types exposing (..)


initialModel : Model
initialModel =
  { email = ""
  , windSpeed = "11"
  , windDirections = []
  , availableDays = [ Mon, Tue, Wed, Thu, Fri, Sat, Sun ]
  , daysVisible = False
  }



-- UPDATE


update : Action -> Model -> ( Model, Effects a )
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

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

    ToggleWindDirection direction ->
      let
        toggledList =
          if List.member direction model.windDirections then
            List.filter (\d -> d /= direction) model.windDirections
          else
            direction :: model.windDirections
      in
        ( { model
            | windDirections = toggledList
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
