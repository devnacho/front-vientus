module App.State (init, update) where

import Effects exposing (Effects)
import App.Types exposing (..)
import Form.State


init : ( Model, Effects Action )
init =
  ( initialModel
  , Effects.batch initialEffects
  )


initialModel : Model
initialModel =
  { form = fst Form.State.init
  }


initialEffects : List (Effects Action)
initialEffects =
  [ Effects.map Form <| snd Form.State.init
  ]



-- UPDATE


update : Action -> Model -> ( Model, Effects Action )
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
