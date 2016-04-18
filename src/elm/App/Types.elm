module App.Types (..) where

import WindDirection.Types 
import AvailableDays.Types 

type Action
  = NoOp
  | AvailableDays AvailableDays.Types.Action
  | WindDirection WindDirection.Types.Action
  | SetEmail String
  | SetWindSpeed String


type alias Model =
  { email : String
  , windSpeed : String
  , windDirections : WindDirection.Types.Model
  , availableDays : AvailableDays.Types.Model
  }



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


type CssClasses
  = FormField
