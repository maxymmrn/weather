class DayWeather {
  DayWeather({this.temperature, this.windSpeed});

  final double temperature;
  final double windSpeed;

  get description {
    if (temperature > 10) {
      return 'Sunny';
    } else if (temperature > 0) {
      return 'Clouds';
    } else {
      return 'Snowing';
    }
  }

}