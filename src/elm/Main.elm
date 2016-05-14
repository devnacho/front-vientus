module Main exposing (..)

import Html.App as Html
import Task

import App.Types exposing (..)
import App.State exposing (init, update)
import App.View exposing (root)


main =
  Html.program
    { init = App.State.init
    , update = App.State.update
    , view = App.View.root
    , subscriptions = \_ -> Sub.none
    }


