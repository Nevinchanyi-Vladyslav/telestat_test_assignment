import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:telestat_test_assignment/core/di/injection.dart' as di;
import 'package:telestat_test_assignment/features/main/main_page.dart';
import 'package:telestat_test_assignment/features/object_list/presentation/pages/create_edit_object/create_edit_object_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await di.init();
  runApp(
    EasyLocalization(
      useOnlyLangCode: true,
      supportedLocales: const [
        Locale('en'),
        Locale('uk'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
        ),
      ),
      locale: context.locale,
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      debugShowCheckedModeBanner: false,
      initialRoute: MainPage.name,
      routes: {
        MainPage.name: (_) => const MainPage(),
        CreateEditObjectPageProvider.name: (_) =>
            const CreateEditObjectPageProvider(),
      },
    );
  }
}
