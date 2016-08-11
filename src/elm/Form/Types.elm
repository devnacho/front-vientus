module Form.Types exposing (..)

import AvailableDays.Types
import Task
import Translation.Utils exposing (..)
import Http


type Msg
  = AvailableDays AvailableDays.Types.Msg
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
  | HttpFail Http.Error
  | ShareVientus String
  | ToggleWindDirection WindDirection


type alias Model =
  { email : String
  , windSpeed : String
  , windDirections : List WindDirection
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
  , windDirections : List WindDirection
  , availableDays : AvailableDays.Types.Model
  , selectedSpotId : String
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

allWindDirections : List WindDirection
allWindDirections =
  [ N, NE, E, SE, S, SW, W, NW ]

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
