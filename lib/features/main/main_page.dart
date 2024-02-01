import 'package:flutter/material.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/pages/object_list/object_list_page.dart';
import 'package:telestat_test_assignment/features/open_weather_map/presentation/pages/open_weather/open_weather_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String name = '/';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: OpenWeatherPageProvider(),
            ),
            Expanded(
              flex: 2,
              child: ObjectListPageProvider(),
            ),
          ],
        ),
      ),
    );
  }
}
