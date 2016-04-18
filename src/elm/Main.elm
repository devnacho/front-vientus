module Main (..) where

import Effects exposing (Effects)
import StartApp

import App.Types exposing (..)
import App.State exposing (initialModel, update)
import App.View exposing (root)


init =
  ( App.State.initialModel, Effects.none )


app =
  StartApp.start
    { init = init
    , update = App.State.update
    , view = App.View.root
    , inputs = [ Signal.map (always NoOp) swap ]
    }


main =
  app.html



-- HOT-SWAPPING


port swap : Signal.Signal Bool
