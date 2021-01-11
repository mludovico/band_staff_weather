class WeatherUtil {
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'Time for 🍦';
    } else if (temp > 20) {
      return 'Time to 🩳 and 👕';
    } else if (temp < 10) {
      return 'Gonna need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}