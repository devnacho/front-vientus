module App.Types exposing (..)

import Form.Types

type alias Flags = { randomSeed : Int }

type Msg
  = NoOp
  | Form Form.Types.Msg


type alias Model =
  { form : Form.Types.Model
  , randomSeed : Int
  }


type GlobalCssClasses
  = Main


