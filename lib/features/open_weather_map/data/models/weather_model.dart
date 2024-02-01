import 'package:json_annotation/json_annotation.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel {
  final List<WeatherInfo> weather;
  final MainInfo main;

  WeatherModel({required this.weather, required this.main});

  factory WeatherModel.fromJson(Map<String, dynamic> json) => _$WeatherModelFromJson(json);
}

@JsonSerializable()
class WeatherInfo {
  final int id;
  
  WeatherInfo({required this.id});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) => _$WeatherInfoFromJson(json);
}

@JsonSerializable()
class MainInfo {
  final double temp;

  MainInfo({required this.temp});

  factory MainInfo.fromJson(Map<String, dynamic> json) => _$MainInfoFromJson(json);
}
