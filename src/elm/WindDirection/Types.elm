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


wdToStr : WindDirection -> String
wdToStr windDirection =
  case windDirection of 
    N -> "N"  
    NE -> "NE"  
    E -> "E"  
    SE -> "SE"  
    S -> "S"  
    SW -> "SW"  
    W -> "W"  
    NW -> "NW"  
