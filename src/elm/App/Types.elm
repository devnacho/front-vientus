module App.Types (..) where


type Action
  = NoOp
  | SetEmail String
  | SetWindSpeed String
  | ToggleWindDirection WindDirection
  | ToggleDay DayOfWeek
  | ToggleDaysVisibility


type alias Model =
  { email : String
  , windSpeed : String
  , windDirections : List WindDirection
  , availableDays : List DayOfWeek
  , daysVisible : Bool
  }


type WindDirection
  = N
  | NE
  | E
  | SE
  | S
  | SW
  | W
  | NW


type DayOfWeek
  = Mon
  | Tue
  | Wed
  | Thu
  | Fri
  | Sat
  | Sun


allWindDirections : List WindDirection
allWindDirections =
  [ N, NE, E, SE, S, SW, W, NE ]


allDaysOfWeek : List DayOfWeek
allDaysOfWeek =
  [ Mon, Tue, Wed, Thu, Fri, Sat, Sun ]
