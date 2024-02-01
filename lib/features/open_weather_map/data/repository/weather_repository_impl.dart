import 'package:dartz/dartz.dart';
import 'package:telestat_test_assignment/core/domain/failures/failures.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/data_sources/interfaces/weather_data_source.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/exceptions/exceptions.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/mapper/weather_mapper.dart';
import 'package:telestat_test_assignment/features/open_weather_map/domain/entities/weather_entity.dart';
import 'package:telestat_test_assignment/features/open_weather_map/domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl with WeatherMapper implements WeatherRepository {
  final WeatherDataSource dataSource;

  WeatherRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, WeatherEntity>> fetchWeather(
      {required double latitude, required double longitude}) async {
    try {
      final responseModel = await dataSource.fetchWeather(latitude, longitude);
      final weatherEntity = fromWeatherModel(responseModel);

      return Right(weatherEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    } on Exception catch (e) {
      return Left(ServerFailure(stackTrace: e.toString()));
    }
  }
}
