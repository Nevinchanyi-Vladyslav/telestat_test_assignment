// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
      main: MainInfo.fromJson(json['main'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'weather': instance.weather,
      'main': instance.main,
    };

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) => WeatherInfo(
      id: json['id'] as int,
    );

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
    };

MainInfo _$MainInfoFromJson(Map<String, dynamic> json) => MainInfo(
      temp: (json['temp'] as num).toDouble(),
    );

Map<String, dynamic> _$MainInfoToJson(MainInfo instance) => <String, dynamic>{
      'temp': instance.temp,
    };
