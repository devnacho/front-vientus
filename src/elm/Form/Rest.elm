module Form.Rest (..) where

import Form.Types exposing (..)
import Http
import Json.Encode as Json
import Json.Decode.Extra exposing ((|:))
import Json.Decode exposing (Decoder, list, succeed, string, float, int, (:=))
import Effects exposing (Effects)
import Task


getCountries =
  Http.get countriesListDecoder "http://localhost:3000/countries.json"
    |> Task.toMaybe
    |> Task.map (\list -> SetCountries list)
    |> Effects.task


countriesListDecoder =
  list countryDecoder


countryDecoder : Decoder Country
countryDecoder =
  succeed Country
    |: ("name" := string)
    |: ("id" := string)


getRegions countryId =
  Http.get regionsListDecoder ("http://localhost:3000/countries/" ++ countryId ++ "/regions.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetRegions list)
    |> Effects.task


regionsListDecoder =
  list regionDecoder


regionDecoder : Decoder Region
regionDecoder =
  succeed Region
    |: ("name" := string)
    |: ("id" := string)


getCountrySpots countryId =
  Http.get spotsListDecoder ("http://localhost:3000/countries/" ++ countryId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


getRegionSpots regionId =
  Http.get spotsListDecoder ("http://localhost:3000/regions/" ++ regionId ++ "/spots.json")
    |> Task.toMaybe
    |> Task.map (\list -> SetSpots list)
    |> Effects.task


spotsListDecoder =
  list spotDecoder


spotDecoder : Decoder Spot
spotDecoder =
  succeed Spot
    |: ("name" := string)
    |: ("id" := string)
    |: ("latitude" := float)
    |: ("latitude" := float)
