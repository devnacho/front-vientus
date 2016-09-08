port module App.Ports exposing (..)

import Form.Types exposing (Country, Spot)

port share : String -> Cmd msg

port setMarkers : List Spot -> Cmd msg

port setSelectedMarker : { prevSelectedSpot : Maybe Spot, newSelectedSpot : Maybe Spot } -> Cmd msg

port selectSpot : (String -> msg) -> Sub msg
