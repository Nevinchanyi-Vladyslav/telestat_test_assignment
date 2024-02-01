part of 'open_weather_cubit.dart';

sealed class OpenWeatherState extends Equatable {
  const OpenWeatherState();

  @override
  List<Object> get props => [];
}

final class OpenWeatherStateInitial extends OpenWeatherState {}

final class OpenWeatherStateLoading extends OpenWeatherState {}

final class OpenWeatherStateLoaded extends OpenWeatherState {
  final String message;
  final String temp;
  final String city;

  const OpenWeatherStateLoaded(
      {required this.message, required this.temp, required this.city});
}

final class OpenWeatherStateError extends OpenWeatherState {
  final String message;

  const OpenWeatherStateError({required this.message});
}
