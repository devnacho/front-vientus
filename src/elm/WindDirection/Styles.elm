module WindDirection.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import WindDirection.Types exposing (..)


css =
  (stylesheet << namespace "WindDir")
    [ (.) Chooser
        [ position relative
        , width (px 250)
        , height (px 250)
        , margin4 (px 20) auto (px 50) auto
        ]
    ]

