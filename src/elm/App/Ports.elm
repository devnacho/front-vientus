port module App.Ports exposing (..)

import Form.Types exposing (Country, Spot)

port share : String -> Cmd msg

port setMapBoundary : Maybe Country -> Cmd msg

port setMarkers : List Spot -> Cmd msg
