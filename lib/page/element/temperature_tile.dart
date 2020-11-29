import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/model/day_weather.dart';

class TemperatureTile extends StatelessWidget {

  TemperatureTile({this.day});

  final DayWeather day;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(FontAwesomeIcons.thermometerHalf),
      title: Text("Temperature"),
      trailing: Text(day != null ? "${day.temperature}\u00B0" : "Loading"),
    );
  }

}