module Form.Types (..) where

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
