module WindDirection.Styles exposing (css)

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import WindDirection.Types exposing (..)

size = 
  270

arrowWidth = 
  40


css =
  (stylesheet << namespace "WindDir")
    <| List.append
      [ (.) Chooser
          [ position relative
          , width (px size)
          , height (px size)
          , margin4 (px 40) auto (px 50) auto
          ]
      , (.) Direction
          [ position absolute
          , width (px arrowWidth)
          , height (px (size/2))
          , margin2 (px 0) (px ((size - arrowWidth) / 2))
          , color (hex "CCC") 
          , property "pointer-events" "none"
          , property "transform-origin" "center bottom"
          , hover
            [ color (hex "55D3A1") 
            ]
          ]
      , (.) Selected
          [ fontWeight bold
          , color (hex "20AA73") 
          , hover
            [ color (hex "20AA73") 
            ]
          ]
      , (.) Icon
          [ fontSize (px 45)
          , display block
          , paddingTop (px 30)
          , property "pointer-events" "all"
          , property "cursor" "pointer"
          ]
      , (.) Text
          [ position absolute
          , top (px 0)
          , left (px ( (arrowWidth/2) - 5)  )
          , property "pointer-events" "all"
          , property "cursor" "pointer"
          ]
      ]
      ( List.map direction [1..8] )


direction index =
  let
    degrees = (index - 1) * 45
  in
    (.) Direction
        [ ( nthChild (toString index)  )
            [ transforms
                [ rotate (deg degrees ) ]
            ]
        , descendants
            [ (.) Text
                [ transforms
                    [ rotate (deg (0 - degrees ) ) ]
                ]
            ]
        ]
