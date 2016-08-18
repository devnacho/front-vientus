port module App.Ports exposing (..)

import Form.Types exposing (Country)

port share : String -> Cmd msg

port setMapBoundary : Maybe Country -> Cmd msg
