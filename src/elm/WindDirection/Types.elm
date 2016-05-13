module WindDirection.Types exposing (..)


type WindDirection
  = N
  | NE
  | E
  | SE
  | S
  | SW
  | W
  | NW


type Msg
  = ToggleWindDirection WindDirection


type alias Model =
  List WindDirection

type CssClasses
  = Direction
  | Selected
  | Chooser
  | Arrow
  | Text
  | Icon

allWindDirections : List WindDirection
allWindDirections =
  [ N, NE, E, SE, S, SW, W, NW ]


