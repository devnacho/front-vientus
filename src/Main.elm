import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing ( onClick )
import Effects exposing (Effects)

import StartApp


-- APP KICK OFF!
app = StartApp.start
  { init = init
  , update = update
  , view = view
  , inputs = [ Signal.map (always NoOp) swap]
  }

main = app.html

-- HOT-SWAPPING
port swap : Signal.Signal Bool

-- MODEL
type alias Model = Int

-- INIT
init =
  (0, Effects.none)

view address model =
  div
    []
    [ h1 [] [ text "Never Miss a Windy Day Again." ]
    , Html.form 
      [ id "signup-form" ]
      [ div
        [ class "form-field" ]
        [ label [] [ text "Email" ]
        , input [ id "username-field", type' "text" ] []
        ]
      , div
        [ class "form-field" ]
        [ label [] [ text "Select Country" ]
        , select
          []
          [ option [ id "1" ] [ text "Argentina" ]
          , option [ id "2" ] [ text "Spain" ]
          ]
        ]
      , div
        [ class "form-field" ]
        [ label [] [ text "Minimum Wind Speed (in knots)" ]
        , input [ type' "number" ] []
        ]
      ]
    ]


-- UPDATE
type Action 
  = NoOp
  | Increment

update action model =
  case action of
    NoOp -> ( model, Effects.none )
    Increment -> ( model + 1, Effects.none )

