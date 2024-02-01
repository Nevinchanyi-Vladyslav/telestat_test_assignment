import 'package:telestat_test_assignment/features/open_weather_map/data/models/weather_model.dart';

abstract class WeatherDataSource{
  Future<WeatherModel> fetchWeather(double latitude, double longitude);
}