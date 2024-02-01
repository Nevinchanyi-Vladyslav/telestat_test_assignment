import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:telestat_test_assignment/core/api/api_keys.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/data_sources/interfaces/weather_data_source.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/exceptions/exceptions.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/models/weather_model.dart';

class RemoteWeatherDataSource implements WeatherDataSource {
  final http.Client client;

  RemoteWeatherDataSource(this.client);

  static const String _apiBaseUrl = 'api.openweathermap.org';
  static const String _apiPath = 'data/2.5';
  static const String _endPoing = 'weather';

  Uri _buildUri({required double lat, required double lon}) {
    return Uri.https(
      _apiBaseUrl,
      '/$_apiPath/$_endPoing',
      {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'appid': APIKeys.openWeatherAPIKey,
        'units': 'metric',
      },
    );
  }

  @override
  Future<WeatherModel> fetchWeather(double latitude, double longitude) async {
    final response = await client.get(
      _buildUri(lat: latitude, lon: longitude),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      return WeatherModel.fromJson(responseBody);
    } else {
      throw ServerException(response.statusCode);
    }
  }
}
