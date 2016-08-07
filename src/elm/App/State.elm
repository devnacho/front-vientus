module App.State exposing (init, update)

import App.Types exposing (..)
import Form.State


init : Flags -> ( Model, Cmd Msg )
init { randSeed } =
  ( initialModel randSeed
  , Cmd.batch initialCommands
  )


initialModel : Int -> Model
initialModel randSeed =
  { form = Form.State.initialModel randSeed
  }


initialCommands : List (Cmd Msg)
initialCommands =
  [ Cmd.map Form <| Cmd.batch Form.State.initialCommands
  ]



-- UPDATE


update : Msg -> Model -> ( Model, Cmd Msg )
update action model =
  case action of
    NoOp ->
      ( model, Cmd.none )

    Form action ->
      let
        ( childModel, childCommands ) =
          Form.State.update action model.form
      in
        ( { model
            | form = childModel
          }
        , Cmd.map Form childCommands
        )
