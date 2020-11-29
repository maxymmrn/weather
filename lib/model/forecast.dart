import 'package:weather/model/day_weather.dart';
import 'city.dart';

class Forecast {
  Forecast({this.city, this.today, this.tomorrow, this.inTwoDays});

  final City city;
  final DayWeather today;
  final DayWeather tomorrow;
  final DayWeather inTwoDays;

}