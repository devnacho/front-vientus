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
    [ class "mt-palette-accent", style styles.wrapper ]
    [  p [ style [( "color", "#FFF")] ] [ text ( "Elm Webpack Starter" ) ]
    ,  button [ class "mt-button-sm", onClick address Increment ] [ text "FTW!" ]
    ,  img [ src "img/elm.jpg", style [( "display", "block"), ( "margin", "10px auto")] ] []
    ]


-- UPDATE
type Action 
  = NoOp
  | Increment

update action model =
  case action of
    NoOp -> ( model, Effects.none )
    Increment -> ( model + 1, Effects.none )


-- CSS STYLES
styles =
  {
    wrapper =
      [ ( "padding-top", "10px" )
      , ( "padding-bottom", "20px" )
      , ( "text-align", "center" )
      ]
  }
  
