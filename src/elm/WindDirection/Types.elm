module WindDirection.Types (..) where


type WindDirection
  = N
  | NE
  | E
  | SE
  | S
  | SW
  | W
  | NW


type Action
  = ToggleWindDirection WindDirection


type alias Model =
  List WindDirection


allWindDirections : List WindDirection
allWindDirections =
  [ N, NE, E, SE, S, SW, W, NE ]
