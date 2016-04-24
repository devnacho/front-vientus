module Form.Rest (..) where

import Form.Types exposing (..)
import WindDirection.Types exposing (wdToStr)
import AvailableDays.Types exposing (dayToStr)
import Http
import Json.Encode as JE
import Json.Decode.Extra exposing ((|:))
import Json.Decode exposing (Decoder, list, succeed, string, float, int, (:=))
import Effects exposing (Effects)
import Task


getCountries : Effects Action
getCountries =
  Http.get countriesListDecoder "http://localhost:3000/countries.json"
    |> Task.toMaybe
    |> Task.map (\list -> SetCountries list)
    |> Effects.task


countriesListDecoder : Decoder (List Country)
countriesListDecoder =
  list countryDecoder


countryDecoder : Decoder Country
countryDecoder =
  succeed Country
    |: ("name" := string)
    |: ("id" := string)


getRegions : String -> Effects Action
getRegions countryId =
  Http.get regionsListDecoder ("http://localhost:3000/countries/" ++ countryId ++ "/regions.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetRegions list)
    |> Effects.task


regionsListDecoder : Decoder (List Region)
regionsListDecoder =
  list regionDecoder


regionDecoder : Decoder Region
regionDecoder =
  succeed Region
    |: ("name" := string)
    |: ("id" := string)


getCountrySpots : String -> Effects Action
getCountrySpots countryId =
  Http.get spotsListDecoder ("http://localhost:3000/countries/" ++ countryId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


getRegionSpots : String -> Effects Action
getRegionSpots regionId =
  Http.get spotsListDecoder ("http://localhost:3000/regions/" ++ regionId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


spotsListDecoder : Decoder (List Spot)
spotsListDecoder =
  list spotDecoder


spotDecoder : Decoder Spot
spotDecoder =
  succeed Spot
    |: ("name" := string)
    |: ("id" := string)
    |: ("latitude" := float)
    |: ("latitude" := float)


submitParams : SubmitModel -> List ( String, String )
submitParams submitModel =
  List.append
    (List.map (\wd -> ( "alert[wind_directions][]", wdToStr wd )) submitModel.windDirections)
    (List.map (\day -> ( "alert[dates][]", dayToStr day )) submitModel.availableDays.days)
    |> List.append
        [ ( "alert[user_attributes][locale]", "EN" )
        , ( "alert[user_attributes][email]", submitModel.email )
        , ( "alert[spot_id]", submitModel.selectedSpot.id )
        , ( "alert[min_speed]", submitModel.windSpeed )
        ]


encodedUrl : SubmitModel -> String
encodedUrl submitModel =
  Http.url "http://localhost:3000/alerts" (submitParams submitModel)


submitAlert : SubmitModel -> Effects Action
submitAlert submitModel =
  Http.post submitDecoder (encodedUrl submitModel) Http.empty
    |> Task.toResult
    |> Task.map (\result -> NoOp)
    |> Effects.task



-- This code is not correct


submitDecoder : Decoder ()
submitDecoder =
  succeed ()
