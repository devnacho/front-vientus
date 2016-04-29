module Form.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import Form.Types exposing (..)


css =
  (stylesheet << namespace "Form")
    [ (.) FormSection
        [  width (pct 50)
        , padding4 (px 20) (px 30) (px 80) (px 30)
        , boxSizing borderBox
        , textAlign center
        ]
    , (.) SidebarSection
        [ position fixed
        , top (px 0)
        , right (px 0)
        , height (pct 100)
        , width (pct 50)
        , property "background" "url(http://www.kitesurfwallpaper.com/images/papers/best-kiteboarding-youri-zoon-low-pass-hd-2.jpg) center center"
        , property "background-size" "cover"
        ]
    , (.) SidebarOverlay
        [ backgroundColor (rgba 111 60 135 0.7)
        , height (pct 100)
        , width (pct 100)
        ]
    , (.) Container
        [ maxWidth (px 480)
        , margin2 (px 0) auto
        ]
    , (.) Group
        [ marginBottom (px 25)
        ]
    , (.) SubmitButton
        [ backgroundColor (hex "FFF")
        , padding2 (px 15) (px 60)
        , textTransform uppercase
        , fontSize (px 18)
        , color (hex "6F3C87")
        , border3 (px 3) solid (hex "6F3C87")
        , display inlineBlock
        , textDecoration none
        , margin (px 0)
        , fontSize (em 1)
        , borderRadius (px 0)
        , fontWeight bold
        , property "cursor" "pointer" 
        ]
    , (.) Title
        [ color (hex "6F3C87")
        , fontWeight bolder
        , fontSize (px 50)
        , textTransform uppercase
        ]
    , (.) Subtitle
        [ color (hex "746F77")
        , fontSize (px 14)
        ]
    , (.) Hint
        [ margin2 (px 50) (px 30)
        , fontSize (px 12)
        , color (hex "AFAFAF")
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


