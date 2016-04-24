module Form.Types (..) where

import WindDirection.Types
import AvailableDays.Types
import Task
import Http



type Action
  = NoOp
  | AvailableDays AvailableDays.Types.Action
  | WindDirection WindDirection.Types.Action
  | SetEmail String
  | SetWindSpeed String
  | SetCountries (Maybe (List Country))
  | SelectCountry String
  | SetRegions (Maybe (List Region))
  | SelectRegion String
  | SetSpots (Maybe (List Spot))
  | SelectSpot String
  | SubmitAlert
  | AlertSubmitted (Result Http.Error ())


type alias Model =
  { email : String
  , windSpeed : String
  , windDirections : WindDirection.Types.Model
  , availableDays : AvailableDays.Types.Model
  , countries : List Country
  , selectedCountry : Maybe Country
  , regions : List Region
  , selectedRegion : Maybe Region
  , spots : List Spot
  , selectedSpot : Maybe Spot
  }

type alias SubmitModel = 
  { email : String
  , windSpeed : String
  , windDirections : WindDirection.Types.Model
  , availableDays : AvailableDays.Types.Model
  , selectedSpot : Spot
  }


type alias Country =
  { name : String
  , id : String
  }

type alias Region =
  { name : String
  , id : String
  }

type alias Spot =
  { name : String
  , id : String
  , latitude: Float
  , longitude: Float
  }


type CssClasses
  = FormSection
  | SidebarSection
  | Container
