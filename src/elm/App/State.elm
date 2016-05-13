module App.State exposing (init, update)

import App.Types exposing (..)
import Form.State


init : ( Model, Cmd Msg )
init =
  ( initialModel
  , Cmd.batch initialCommands
  )


initialModel : Model
initialModel =
  { form = fst Form.State.init
  }


initialCommands : List (Cmd Msg)
initialCommands =
  [ Cmd.map Form <| snd Form.State.init
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
