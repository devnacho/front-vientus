module AvailableDays.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import AvailableDays.Types exposing (..)

css =
  (stylesheet << namespace "Days")
      []
