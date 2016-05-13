module AvailableDays.Types exposing (..)


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

dayToStr : DayOfWeek -> String
dayToStr day  =
  case day of 
    Sun -> "0"  
    Mon -> "1"  
    Tue -> "2"  
    Wed -> "3"  
    Thu -> "4"  
    Fri -> "5"  
    Sat -> "6"  

type CssClasses
  = Button
  | Selected
  | Icon
  | Toggle
  | DateIcon
