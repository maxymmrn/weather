import 'package:flutter/animation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:weather/model/day_weather.dart';


class WeatherTile extends StatelessWidget {

  WeatherTile({this.controller, this.day});

  final AnimationController controller;
  final DayWeather day;

  @override
  Widget build(BuildContext context) {
    FaIcon icon;
    Curve curve;
    if (day != null) {
      if (day.description == 'Sunny') {
        icon = FaIcon(FontAwesomeIcons.solidSun);
        curve = Curves.elasticOut;
      } else if (day.description == 'Clouds') {
        icon = FaIcon(FontAwesomeIcons.cloud);
        curve = Curves.fastLinearToSlowEaseIn;
      } else if (day.description == 'Snowing') {
        icon = FaIcon(FontAwesomeIcons.snowflake);
        curve = Curves.linear;
      } else {
        icon = FaIcon(FontAwesomeIcons.cloudSun);
        curve = Curves.linear;
      }
    } else {
      icon = FaIcon(FontAwesomeIcons.cloudSun);
      curve = Curves.linear;
    }
    return ListTile(
      leading: day != null && (day.description == 'Sunny' || day.description == 'Snowing')
          ? RotationTransition(
          turns: CurvedAnimation(
            parent: controller,
            curve: curve,
          ),
          child: icon
      )
          : FadeTransition(
          opacity: CurvedAnimation(
            parent: controller,
            curve: curve,
          ),
          child: icon
      ),
      title: Text("Weather"),
      trailing: Text(day != null ? "${day.description}" : "Loading"),
    );
  }

}