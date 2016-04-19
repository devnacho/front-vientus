module Form.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import Form.Types exposing (..)


css =
  (stylesheet << namespace "Form")
    [ (.)
        Container
        [ maxWidth (px 480)
        , margin2 (px 0) auto
        ]
    ]


