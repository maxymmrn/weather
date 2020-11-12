import 'city.dart';

class Forecast {
  Forecast({
    this.city,
    this.today,
    this.tomorrow,
    this.twoDays
  });

  final City city;
  final double today;
  final double tomorrow;
  final double twoDays;

}