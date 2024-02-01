import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:telestat_test_assignment/features/open_weather_map/domain/repositories/weather_repository.dart';
import 'package:telestat_test_assignment/features/open_weather_map/presentation/utils/failure_message_mapper.dart';

part 'open_weather_state.dart';

class OpenWeatherCubit extends Cubit<OpenWeatherState>
    with FailureToMessageMapper {
  OpenWeatherCubit(this.repository) : super(OpenWeatherStateInitial());

  final WeatherRepository repository;
  String _city = '';

  void fetchWeather() async {
    emit(OpenWeatherStateLoading());

    try {
      final position = await _getCoordinates();
      final latitude = position.latitude;
      final longitude = position.longitude;
      _city = await _getCity(latitude, longitude);

      final weatherOrFailure = await repository.fetchWeather(
          latitude: latitude, longitude: longitude);

      weatherOrFailure.fold(
        (failure) => emit(
          OpenWeatherStateError(
            message: mapFailureToMessage(failure),
          ),
        ),
        (weatherEntity) => emit(
          OpenWeatherStateLoaded(
            message: getMessage(weatherEntity.temp),
            temp:
                '${weatherEntity.temp} ${getWeatherIcon(weatherEntity.weatherId)}',
            city: _city,
          ),
        ),
      );
    } catch (e) {
      
    }
  }

  Future<void> _handlePermission() async {
    await Geolocator.requestPermission();
    bool isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      emit(
        OpenWeatherStateError(
          message: 'turn_on_geolocation'.tr(),
        ),
      );
      return Future.error('Location not enabled');
    }
    LocationPermission locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.deniedForever) {
      emit(
        OpenWeatherStateError(
          message: 'turn_on_geolocation'.tr(),
        ),
      );
      return Future.error('Location permission are denied forever');
    } else if (locationPermission == LocationPermission.denied) {
      emit(
        OpenWeatherStateError(
          message:
              'allow_permission'.tr(),
        ),
      );
      return Future.error('Location permission is denied');
    }
  }

  Future<Position> _getCoordinates() async {
    await _handlePermission();
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<String> _getCity(double latitude, double longitude) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);
    Placemark place = placemarks[0];
    return place.locality!;
  }

  String getWeatherIcon(int id) {
    if (id < 300) {
      return '🌩';
    } else if (id < 400) {
      return '🌧';
    } else if (id < 600) {
      return '☔️';
    } else if (id < 700) {
      return '☃️';
    } else if (id < 800) {
      return '🌫';
    } else if (id == 800) {
      return '☀️';
    } else if (id <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return '25_temp_message'.tr();
    } else if (temp > 20) {
      return '20_temp_message'.tr();
    } else if (temp < 10) {
      return '10_temp_message'.tr();
    } else {
      return 'else_temp_message'.tr();
    }
  }
}
