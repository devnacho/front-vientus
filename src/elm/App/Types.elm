module App.Types (..) where

import WindDirection.Types 

type Action
  = NoOp
  | SetEmail String
  | SetWindSpeed String
  | ToggleDay DayOfWeek
  | ToggleDaysVisibility
  | WindDirection WindDirection.Types.Action


type alias Model =
  { email : String
  , windSpeed : String
  , windDirections : WindDirection.Types.Model
  , availableDays : List DayOfWeek
  , daysVisible : Bool
  }



type DayOfWeek
  = Mon
  | Tue
  | Wed
  | Thu
  | Fri
  | Sat
  | Sun



allDaysOfWeek : List DayOfWeek
allDaysOfWeek =
  [ Mon, Tue, Wed, Thu, Fri, Sat, Sun ]
