import 'dart:convert';
import 'package:http/http.dart';
import 'package:weather/model/day_weather.dart';
import 'model/city.dart';
import 'model/forecast.dart';


Future<List<City>> getCities(String namePrefix) async {
  Uri uri = Uri.https("wft-geo-db.p.rapidapi.com", "/v1/geo/cities", {
    "namePrefix": namePrefix
  });

  Response response = await get(uri, headers: {
    'x-rapidapi-key': "286a8b3755msh6053b25885c25ddp16ef73jsnd1d49e1a3acd",
    'x-rapidapi-host': "wft-geo-db.p.rapidapi.com"
  });

  List<City> cities = [];
  for (var item in jsonDecode(response.body)['data']) {
    cities.add(
        City(
            name: item['city'],
            latitude: item['latitude'],
            longitude: item['longitude']
        )
    );
  }

  return cities;
}

Future<Forecast> getForecast(City city) async {
    Uri uri = Uri.https(
        "api.met.no", "/weatherapi/locationforecast/2.0/compact.json", {
        "lat": '${city.latitude}',
        "lon": '${city.longitude}'
    });

    Response response = await get(uri, headers: {
      'Content-type': 'application/json'
    });

    var timeSeries = jsonDecode(response.body)['properties']['timeseries'];

    return Forecast(
        city: city,
        today: DayWeather(
          temperature: timeSeries[0]['data']['instant']['details']['air_temperature'],
          windSpeed: timeSeries[0]['data']['instant']['details']['wind_speed'],
        ),
        tomorrow: DayWeather(
          temperature: timeSeries[24]['data']['instant']['details']['air_temperature'],
          windSpeed: timeSeries[24]['data']['instant']['details']['wind_speed'],
        ),
        inTwoDays: DayWeather(
          temperature: timeSeries[48]['data']['instant']['details']['air_temperature'],
          windSpeed: timeSeries[48]['data']['instant']['details']['wind_speed'],
        ),
    );
  }