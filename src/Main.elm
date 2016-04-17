module Main (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, targetValue, on, targetChecked)
import String exposing (toInt)
import Effects exposing (Effects)
import StartApp


-- APP KICK OFF!


app =
  StartApp.start
    { init = init
    , update = update
    , view = view
    , inputs = [ Signal.map (always NoOp) swap ]
    }


main =
  app.html



-- HOT-SWAPPING


port swap : Signal.Signal Bool



-- MODEL


type WindDirection
  = N
  | NE
  | E
  | SE
  | S
  | SW
  | W
  | NW


type DayOfWeek
  = Mon
  | Tue
  | Wed
  | Thu
  | Fri
  | Sat
  | Sun


type alias Model =
  { email : String
  , windSpeed : String
  , windDirections : List WindDirection
  , availableDays : List DayOfWeek
  , daysVisible : Bool
  }


initialModel : Model
initialModel =
  { email = ""
  , windSpeed = "11"
  , windDirections = []
  , availableDays = [ Mon, Tue, Wed, Thu, Fri, Sat, Sun ]
  , daysVisible = False
  }


allWindDirections : List WindDirection
allWindDirections =
  [ N, NE, E, SE, S, SW, W, NE ]


allDaysOfWeek : List DayOfWeek
allDaysOfWeek =
  [ Mon, Tue, Wed, Thu, Fri, Sat, Sun ]



-- INIT


init =
  ( initialModel, Effects.none )


view address model =
  div
    []
    [ h1 [] [ text "Never Miss a Windy Day Again." ]
    , div
        [ id "signup-form" ]
        [ div
            [ class "form-field" ]
            [ label [] [ text "Email" ]
            , input
                [ id "username-field"
                , type' "text"
                , placeholder "your-email@gmail.com"
                , on "input" targetValue (Signal.message address << SetEmail)
                , value model.email
                ]
                []
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
            , input
                [ type' "number"
                , value model.windSpeed
                , on "input" targetValue (Signal.message address << SetWindSpeed)
                ]
                []
            ]
        , div
            [ class "form-field" ]
            [ label [] [ text "Select wind directions" ]
            , div
                []
                (List.map (\wd -> windButton address wd) allWindDirections)
            ]
        , button
            [ onClick address ToggleDaysVisibility ]
            [ text "Want to choose the days you can sail? " ]
        , selectDays address model
        ]
    , br [] []
    , br [] []
    , text (toString model)
    ]


selectDays address model =
  if model.daysVisible then
    div
      [ class "form-field" ]
      [ label [] [ text "Select Days of Week" ]
      , div
          []
          (List.map (\day -> dayButton address day) allDaysOfWeek)
      ]
  else
    span [] []


windButton address windDirection =
  button
    [ onClick address (ToggleWindDirection windDirection) ]
    [ text (toString windDirection) ]


dayButton address day =
  button
    [ onClick address (ToggleDay day) ]
    [ text (toString day) ]



-- UPDATE


type Action
  = NoOp
  | SetEmail String
  | SetWindSpeed String
  | ToggleWindDirection WindDirection
  | ToggleDay DayOfWeek
  | ToggleDaysVisibility


update action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    SetEmail str ->
      ( { model
          | email = str
        }
      , Effects.none
      )

    SetWindSpeed str ->
      ( { model
          | windSpeed = str
        }
      , Effects.none
      )

    ToggleDaysVisibility ->
      ( { model
          | daysVisible = not model.daysVisible
        }
      , Effects.none
      )

    ToggleWindDirection direction ->
      let
        toggledList =
          if List.member direction model.windDirections then
            List.filter (\d -> d /= direction) model.windDirections
          else
            direction :: model.windDirections
      in
        ( { model
            | windDirections = toggledList
          }
        , Effects.none
        )

    ToggleDay day ->
      let
        toggledList =
          if List.member day model.availableDays then
            List.filter (\d -> d /= day) model.availableDays
          else
            day :: model.availableDays
      in
        ( { model
            | availableDays = toggledList
          }
        , Effects.none
        )
