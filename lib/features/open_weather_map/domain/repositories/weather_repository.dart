import 'package:dartz/dartz.dart';
import 'package:telestat_test_assignment/core/domain/failures/failures.dart';
import 'package:telestat_test_assignment/features/open_weather_map/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> fetchWeather(
      {required double latitude, required double longitude});
}
