import 'package:telestat_test_assignment/features/open_weather_map/data/models/weather_model.dart';
import 'package:telestat_test_assignment/features/open_weather_map/domain/entities/weather_entity.dart';

mixin WeatherMapper {
  WeatherEntity fromWeatherModel(WeatherModel model) {
    return WeatherEntity(
      temp: model.main.temp.round(),
      weatherId: model.weather[0].id,
    );
  }
}
