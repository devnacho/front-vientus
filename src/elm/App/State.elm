module App.State (initialModel, update) where

import Effects exposing (Effects)
import App.Types exposing (..)
import Form.State


initialModel : Model
initialModel =
  {  form = Form.State.initialModel
  }



-- UPDATE


update : Action -> Model -> (Model, Effects Action)
update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    Form action ->
      let
        ( childModel, childEffects ) =
          Form.State.update action model.form
      in
        ( { model
            | form = childModel
          }
        , Effects.map Form childEffects
        )

