import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:telestat_test_assignment/core/di/injection.dart';
import 'package:telestat_test_assignment/core/presentation/widgets/error_message.dart';
import 'package:telestat_test_assignment/features/open_weather_map/presentation/pages/open_weather/cubit/open_weather_cubit.dart';

class OpenWeatherPageProvider extends StatelessWidget {
  const OpenWeatherPageProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OpenWeatherCubit>(
      create: (_) => sl<OpenWeatherCubit>()..fetchWeather(),
      child: const OpenWeatherPage(),
    );
  }
}

class OpenWeatherPage extends StatefulWidget {
  const OpenWeatherPage({super.key});

  @override
  State<OpenWeatherPage> createState() => _OpenWeatherPageState();
}

class _OpenWeatherPageState extends State<OpenWeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 8,
      ),
      child: BlocBuilder<OpenWeatherCubit, OpenWeatherState>(
        builder: (context, state) {
          if (state is OpenWeatherStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is OpenWeatherStateLoaded) {
            final textTheme = Theme.of(context).textTheme;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    state.temp,
                    style: textTheme.headlineLarge,
                  ),
                  Text(
                    state.message,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    state.city,
                    style: textTheme.headlineMedium,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      context.read<OpenWeatherCubit>().fetchWeather();
                    },
                    child: Text('refresh_data'.tr()),
                  ),
                ],
              ),
            );
          } else if (state is OpenWeatherStateError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ErrorMessage(message: state.message),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          context.read<OpenWeatherCubit>().fetchWeather();
                        },
                        child: Text('try_again'.tr()),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
