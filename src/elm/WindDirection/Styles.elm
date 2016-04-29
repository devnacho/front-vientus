module WindDirection.Styles (css) where

import Css exposing (..)
import Css.Elements as Css
import Css.Namespace exposing (namespace)
import WindDirection.Types exposing (..)

size = 
  280


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
          , width (px size)
          , height (px size)
          ]
      , (.) Text
          [ position absolute
          , top (px 0)
          , left (px (size/2) )
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
