import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather/city_search.dart';
import 'package:weather/htpp_requests.dart';
import 'package:weather/model/city.dart';
import 'package:weather/model/forecast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Cities'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<City> _cities = new List<City>();
  List<Forecast> _forecasts = [];

  @override
  Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
          ),
          body: Center(
              child: ListView.builder(
                  itemCount: _forecasts.length,
                  itemBuilder: (BuildContext context, int i) {
                    Forecast forecast = _forecasts[i];
                    return ForecastRow(
                      city: forecast.city.name,
                      firstDay: forecast.today,
                      secondDay: forecast.tomorrow,
                      thirdDay: forecast.twoDays,
                    );
                  }
              )
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              City result = await showSearch<City>(
                  context: context,
                  delegate: CitySearchDelegate()
              );
              if (result != null && result.longitude != null && result.latitude != null) {
                _cities.add(result);
                _forecasts.add(await getForecast(result));
              }
              setState(() {
                print(_forecasts);
              });
            },
            child: Icon(Icons.add),
          ),
        );
  }
}




class ForecastRow extends StatelessWidget{
  ForecastRow({this.city, this.firstDay, this.secondDay, this.thirdDay});

  final String city;
  final double firstDay;
  final double secondDay;
  final double thirdDay;

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(city),
          Text('$firstDay C'),
          Text('$secondDay C'),
          Text('$thirdDay C'),
        ]
    );
  }

}
