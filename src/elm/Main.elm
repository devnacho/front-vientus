module Main exposing (..)

import Html.App as Html
import Task

import App.Types exposing (..)
import App.State exposing (init, update)
import App.View exposing (root)
import App.Ports exposing (selectSpot)

import Form.State


main : Program Flags
main =
  Html.programWithFlags
    { init = App.State.init
    , update = App.State.update
    , view = App.View.root
    , subscriptions = subscriptions
    }


subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.batch
     [ Sub.map Form ( Form.State.subscriptions model.form )
     ]
