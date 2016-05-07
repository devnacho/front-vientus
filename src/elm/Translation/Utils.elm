module Translation.Utils (Language(..), TranslationId(..), i18n) where


type alias TranslationSet =
  { english : String
  , spanish : String
  }


type TranslationId
  = TitleText
  | SubtitleText1
  | SubtitleText2
  | SelectCountryText
  | SelectRegionText
  | SelectSpotText
  | MinSpeedText
  | SelectWindDirText
  | ToggleDaysText
  | SelectDaysText
  | SubmitText
  | HintText
  | ThanksTitleText
  | ShareTitleText1
  | ShareTitleText2
  | ShareHintText


type Language
  = English
  | Spanish


i18n : Language -> TranslationId -> String
i18n lang trans =
  let
    translationSet =
      case trans of
        TitleText ->
          TranslationSet
            "Never Miss a Windy Day Again."
            "No te pierdas un solo día de viento"

        SubtitleText1 ->
          TranslationSet
            "Select the minimum wind speed and the wind directions you need to sail at your spot."
            "TODO"

        SubtitleText2 ->
          TranslationSet
            "Leave us your email and get notified whenever the weather conditions match your preferences."
            "TODO"

        SelectCountryText ->
          TranslationSet
            "Select Country"
            "TODO"

        SelectRegionText ->
          TranslationSet
            "Select Region"
            "TODO"

        SelectSpotText ->
          TranslationSet
            "Select Spot"
            "TODO"

        MinSpeedText ->
          TranslationSet
            "Minimum Wind Speed (in knots)"
            "TODO"

        SelectWindDirText ->
          TranslationSet
            "Select Wind Directions"
            "TODO"

        ToggleDaysText ->
          TranslationSet
            "Want to choose the days you sail?"
            "TODO"

        SelectDaysText ->
          TranslationSet
            "Select days of week"
            "TODO"

        SubmitText ->
          TranslationSet
            "Submit"
            "Enviar"

        HintText ->
          TranslationSet
            "* Hint: If you want to receive alerts from another spot just sign up again with the same email and select it. You will receive alerts for both spots :)"
            "TODO"

        ThanksTitleText ->
          TranslationSet
            "Thanks! Your alert has been succesfully created."
            "TODO"

        ShareTitleText1 ->
          TranslationSet
            "Share it with your friends*."
            "TODO"

        ShareTitleText2 ->
          TranslationSet
            "They'll love it."
            "TODO"

        ShareHintText ->
          TranslationSet
            " * Not sharing with your friends in the next minute could result in 2 months without wind."
            "TODO"
  in
    case lang of
      English ->
        .english translationSet

      Spanish ->
        .spanish translationSet
