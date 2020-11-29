import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/model/day_weather.dart';

class WindSpeedTile extends StatelessWidget {

  WindSpeedTile({this.day});

  final DayWeather day;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(FontAwesomeIcons.wind),
      title: Text("Wind Speed"),
      trailing: Text(day != null ? "${day.windSpeed} m/s" : "Loading"),
    );
  }

}