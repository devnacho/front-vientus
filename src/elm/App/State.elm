module App.State (init, update) where

import Effects exposing (Effects)
import App.Types exposing (..)
import Form.State
import Translation.Utils exposing (..)

init : ( Model, Effects Action )
init =
  ( initialModel
  , Effects.batch initialEffects
  )


initialModel : Model
initialModel =
  { form = Form.State.initialModel initialLanguage
  , language = initialLanguage
  }


initialEffects : List (Effects Action)
initialEffects =
  [ Effects.map Form <| Form.State.initialEffects
  ]


initialLanguage : Language
initialLanguage =
  Spanish

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
