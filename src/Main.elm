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
    [ text "Hello" ]


-- UPDATE
type Action 
  = NoOp
  | Increment

update action model =
  case action of
    NoOp -> ( model, Effects.none )
    Increment -> ( model + 1, Effects.none )

