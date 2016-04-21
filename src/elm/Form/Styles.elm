module Form.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import Form.Types exposing (..)


css =
  (stylesheet << namespace "Form")
    [ (.) FormSection
        [  width (pct 50)
        , height (px 1000)
        , padding2 (px 20) (px 30)
        , boxSizing borderBox
        , textAlign center
        ]
    , (.) SidebarSection
        [ backgroundColor (hex "DBDDF4")
        , position fixed
        , top (px 0)
        , right (px 0)
        , height (pct 100)
        , width (pct 50)
        ]
    , (.) Container
        [ maxWidth (px 480)
        , margin2 (px 0) auto
        ]
    , mediaQuery "screen and (max-width: 600px)"
        [ (.) FormSection
            [ width (pct 100) ]
        ]
    , mediaQuery "screen and (max-width: 600px)"
        [ (.) SidebarSection
            [ display none ]
        ]
    ]


