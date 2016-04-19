module AvailableDays.Types (..) where

type DayOfWeek
  = Mon
  | Tue
  | Wed
  | Thu
  | Fri
  | Sat
  | Sun


type Action
  = ToggleDay DayOfWeek
  | ToggleDaysVisibility


type alias Model =
  { visible : Bool
  , days : List DayOfWeek
  }


allDaysOfWeek : List DayOfWeek
allDaysOfWeek =
  [ Mon, Tue, Wed, Thu, Fri, Sat, Sun ]
