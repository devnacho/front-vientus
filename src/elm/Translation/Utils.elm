module Translation.Utils (Language(..), TranslationId(..), i18n) where


type alias TranslationSet =
  { english : String
  , spanish : String
  }


type TranslationId
  = TitleText
  | SubtitleText1
  | SubtitleText2
  | EmailPlaceholderText
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
  | EmailErrorText
  | WindSpeedErrorText1
  | WindSpeedErrorText2
  | WindDirErrorText
  | DaysErrorText
  | CountryErrorText
  | SpotErrorText


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
            "Elige la velocidad mínima de viento y las direcciones que te sirven para navegar en tu spot."

        SubtitleText2 ->
          TranslationSet
            "Leave us your email and get notified whenever the weather conditions match your preferences."
            "Dejanos tu email y recibe alertas en tu email un día antes de cuando sopla, con las condiciones que elegiste."

        EmailPlaceholderText ->
          TranslationSet
            "your-email@example.com"
            "tu-email@ejemplo.com"

        SelectCountryText ->
          TranslationSet
            "Select Country"
            "Elige tu país"

        SelectRegionText ->
          TranslationSet
            "Select Region"
            "Elige una región"

        SelectSpotText ->
          TranslationSet
            "Select Spot"
            "Elige tu spot"

        MinSpeedText ->
          TranslationSet
            "Minimum Wind Speed (in knots)"
            "Velocidad Minima de Viento (en nudos)"

        SelectWindDirText ->
          TranslationSet
            "Select Wind Directions"
            "Elige las direcciones de viento que te interesan"

        ToggleDaysText ->
          TranslationSet
            "Want to choose the days you sail?"
            "¿Quieres elegir los días que podes navegar?"

        SelectDaysText ->
          TranslationSet
            "Select days of the week"
            "Selecciona los días que puedes navegar"

        SubmitText ->
          TranslationSet
            "Create Alert"
            "Crear Alerta"

        HintText ->
          TranslationSet
            "* Hint: If you want to receive alerts from another spot just sign up again with the same email and select it. You will receive alerts for both spots :)"
            "* Tip: Si querés recibir alertas de otro spot, solamente anotate de nuevo con el mismo email y seleccionalo. Vas a recibir alertas de ambos spots :)"

        ThanksTitleText ->
          TranslationSet
            "Thanks! Your alert has been succesfully created."
            "Gracias! Tu alerta se creó exitosamente."

        ShareTitleText1 ->
          TranslationSet
            "Share it with your friends*."
            "Compartíselo a tus amigos"

        ShareTitleText2 ->
          TranslationSet
            "They'll love it."
            "Les va a encantar."

        ShareHintText ->
          TranslationSet
            " * Not sharing with your friends in the next minute could result in 2 months without wind."
            " * No compartirlo a 3 amigos en los próximos 10 minutos puede resultar en 2 meses sin viento."

        EmailErrorText ->
          TranslationSet
            "Please enter a valid email"
            "Por favor ingresa un email valido"

        WindSpeedErrorText1 ->
          TranslationSet
            "Please enter a number in knots as the minimum speed"
            "Ingresa un numero en nudos como la velocidad minima de viento"

        WindSpeedErrorText2 ->
          TranslationSet
            "Please enter a positive number"
            "La velocidad debe ser mayor a cero"

        WindDirErrorText ->
          TranslationSet
            "Please select at least one wind direction"
            "Selecciona una dirección por lo menos"

        DaysErrorText ->
          TranslationSet
            "Please select at least one day"
            "Selecciona un día por lo menos"

        CountryErrorText ->
          TranslationSet
            "Please select a country"
            "Selecciona un país"

        SpotErrorText ->
          TranslationSet
            "Please select a spot"
            "Selecciona un spot"
  in
    case lang of
      English ->
        .english translationSet

      Spanish ->
        .spanish translationSet
