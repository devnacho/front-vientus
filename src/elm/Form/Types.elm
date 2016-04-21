module Form.Types (..) where

import WindDirection.Types
import AvailableDays.Types


type Action
  = NoOp
  | AvailableDays AvailableDays.Types.Action
  | WindDirection WindDirection.Types.Action
  | SetEmail String
  | SetWindSpeed String
  | SetCountries ( Maybe (List Country) )
  | SelectCountry String


type alias Model =
  { email : String
  , windSpeed : String
  , windDirections : WindDirection.Types.Model
  , availableDays : AvailableDays.Types.Model
  , countries : List Country
  , selectedCountry : Maybe Country
  }


type alias Country =
  { name : String
  , id : String
  }


type CssClasses
  = FormSection
  | SidebarSection
  | Container
