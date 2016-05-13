module Form.Types exposing (..)

import WindDirection.Types
import AvailableDays.Types
import Task
import Translation.Utils exposing (..)


type Action
  = AvailableDays AvailableDays.Types.Action
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
  | SubmitSuccess
  | SubmitFailure
  | ChangeLanguage Language


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
  , errors : Errors
  , status : Status
  , language : Language
  }

type Status
  = Clean
  | Dirty
  | Submitting
  | Failure
  | Success


type alias Errors =
  { email : TranslationId
  , windSpeed : TranslationId
  , windDirections : TranslationId
  , availableDays : TranslationId
  , selectedCountry : TranslationId
  , selectedSpot : TranslationId
  }


type alias SubmitModel =
  { email : String
  , windSpeed : String
  , windDirections : WindDirection.Types.Model
  , availableDays : AvailableDays.Types.Model
  , selectedSpotId : String
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
  , latitude : Float
  , longitude : Float
  }


type CssClasses
  = FormSection
  | SidebarSection
  | SidebarOverlay
  | Container
  | Logo
  | Title
  | Subtitle
  | Group
  | SubmitButton
  | Hint
  | Error
  | ThanksTitle
  | Share
  | ShareTitle
  | ShareIcon
  | ShareHint
  | Facebook
  | Twitter
  | Languages
  | LangIcon
  | LangActive
