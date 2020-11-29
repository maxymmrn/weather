import 'package:flutter/material.dart';
import 'package:weather/http_requests.dart';
import 'package:weather/model/city.dart';
import 'package:weather/model/forecast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/page/city_search.dart';
import 'package:weather/page/element/section_tile.dart';
import 'package:weather/page/element/temperature_tile.dart';
import 'package:weather/page/element/weather_tile.dart';
import 'package:weather/page/element/wind_speed_tile.dart';

import 'model/day_weather.dart';

void main() => runApp(MaterialApp(
      title: 'Turbo Weather App',
      home: HomePage(),
    ));

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {

  AnimationController _controller;

  City city = City(name: 'Lviv', latitude: 49.841888888, longitude: 24.0315);
  DayWeather today;
  DayWeather tomorrow;
  DayWeather inTwoDays;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future setForecast() async {
    Forecast forecast = await getForecast(city);
    setState(() {
      today = forecast.today;
      tomorrow = forecast.tomorrow;
      inTwoDays = forecast.inTwoDays;
    });
  }

  @override
  Widget build(BuildContext context) {
    setForecast();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    city != null ? "Currently in ${city.name}" : "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Text(
                  today != null ? "${today.temperature}\u00B0" : "Loading...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                      fontWeight: FontWeight.w600),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    today != null ? "${today.description}" : "",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 15.0, top: 0, right: 15.0, bottom: 20.0),
                child: ListView(
                  children: <Widget>[
                    SectionTile(text: "Today"),
                    TemperatureTile(day: today),
                    WeatherTile(controller: _controller, day: today),
                    WindSpeedTile(day: today),

                    SectionTile(text: "Tomorrow"),
                    TemperatureTile(day: tomorrow),
                    WeatherTile(controller: _controller, day: tomorrow),
                    WindSpeedTile(day: tomorrow),

                    SectionTile(text: "In Two Days"),
                    TemperatureTile(day: inTwoDays),
                    WeatherTile(controller: _controller, day: inTwoDays),
                    WindSpeedTile(day: inTwoDays),
                  ],
                ),
              ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          City result = await showSearch<City>(
              context: context, delegate: CitySearchDelegate());
          if (result != null &&
              result.longitude != null &&
              result.latitude != null) {
            city = result;
            setForecast();
          }
        },
        child: FaIcon(FontAwesomeIcons.search),
      ),
    );
  }
}
