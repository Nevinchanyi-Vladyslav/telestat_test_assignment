import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:telestat_test_assignment/features/object_list/data/data_sources/interfaces/object_data_source.dart';
import 'package:telestat_test_assignment/features/object_list/data/data_sources/local/hive_local_object_data_source.dart';
import 'package:telestat_test_assignment/features/object_list/data/repositories/object_repository_impl.dart';
import 'package:telestat_test_assignment/features/object_list/domain/repositories/object_repository.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/pages/create_edit_object/cubit/create_edit_cubit_cubit.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/pages/object_list/cubit/object_list_cubit.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/data_sources/interfaces/weather_data_source.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/data_sources/remote/remote_weather_data_source.dart';
import 'package:telestat_test_assignment/features/open_weather_map/data/repository/weather_repository_impl.dart';
import 'package:telestat_test_assignment/features/open_weather_map/domain/repositories/weather_repository.dart';
import 'package:telestat_test_assignment/features/open_weather_map/presentation/pages/open_weather/cubit/open_weather_cubit.dart';

final GetIt sl = GetIt.I;

Future<void> init() async {
  //External
  sl.registerSingleton<http.Client>(
    http.Client(),
  );

  //Domain Layer

  //Data Layer
  sl.registerSingletonAsync<ObjectDataSource>(
    () async => await HiveLocalObjectDataSource.getInstance(),
  );
  sl.registerSingletonWithDependencies<ObjectRepository>(
    () => ObjectRepositoryImpl(
      sl<ObjectDataSource>(),
    ),
    dependsOn: [
      ObjectDataSource,
    ],
  );
  sl.registerSingleton<WeatherDataSource>(
    RemoteWeatherDataSource(
      sl<http.Client>(),
    ),
  );
  sl.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(
      sl<WeatherDataSource>(),
    ),
  );

  //Presentation Layer
  sl.registerFactory<ObjectListCubit>(
    () => ObjectListCubit(
      sl<ObjectRepository>(),
    ),
  );
  sl.registerFactory<CreateEditCubit>(
    () => CreateEditCubit(
      sl<ObjectRepository>(),
    ),
  );
  sl.registerFactory<OpenWeatherCubit>(
    () => OpenWeatherCubit(
      sl<WeatherRepository>(),
    ),
  );

  await sl.allReady();
}
