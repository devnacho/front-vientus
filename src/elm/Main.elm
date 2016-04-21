module Main (..) where

import Effects exposing (Effects)
import StartApp

import App.Types exposing (..)
import App.State exposing (init, update)
import App.View exposing (root)




app =
  StartApp.start
    { init = App.State.init
    , update = App.State.update
    , view = App.View.root
    , inputs = [ Signal.map (always NoOp) swap ]
    }


main =
  app.html



-- HOT-SWAPPING


port swap : Signal.Signal Bool
