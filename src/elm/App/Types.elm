module App.Types exposing (..)

import Form.Types

type alias Flags = { randSeed : Int }

type Msg
  = NoOp
  | Form Form.Types.Msg


type alias Model =
  { form : Form.Types.Model
  }


type GlobalCssClasses
  = Main


