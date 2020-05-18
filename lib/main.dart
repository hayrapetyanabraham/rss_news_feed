import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newsfeed/constants/app_colors.dart';
import 'package:newsfeed/services/background_check.dart';
import 'package:newsfeed/store/database/database_state.dart';

import 'navigator/router.gr.dart';
import 'network/dio.dart';

GetIt getIt = GetIt.instance;

BackgroundCheck backgroundChecker;

void headlessTask() async {
  backgroundChecker = BackgroundCheck.getInstance();
  backgroundChecker.checkUpdate();
}

void main() {
  getIt.registerSingleton(dio);
  runApp(MyApp());
  registerDatabaseState();
  WidgetsFlutterBinding.ensureInitialized();
  backgroundChecker = BackgroundCheck.getInstance();
  BackgroundFetch.registerHeadlessTask(headlessTask);
  backgroundChecker.initPlatformState();
}

Future<void> registerDatabaseState() async {
  GetIt.I.registerSingleton(DatabaseState());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: ExtendedNavigator<Router>(router: Router()),
    );
  }
}

MaterialColor createMaterialColor(Color color) {
  final strengths = <double>[.05];
  final swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }

  for (final strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }

  return MaterialColor(color.value, swatch);
}

ThemeData buildLightTheme() {
  return ThemeData(
    primarySwatch: createMaterialColor(primaryColor),
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: navyColor, size: 15),
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white.withOpacity(0.8),
          fontWeight: FontWeight.bold,
        ),
      ),
      brightness: Brightness.light,
    ),
    accentColor: accentColor,
    buttonTheme: ButtonThemeData(
      buttonColor: primaryColor,
      disabledColor: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      textTheme: ButtonTextTheme.primary,
    ),
    buttonColor: primaryColor,
    textTheme: TextTheme(
      button: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      display1: const TextStyle(
        color: navyColor,
        fontSize: 16,
      ),
    ).apply(
      fontFamily: 'Montserrat',
    ),
    toggleableActiveColor: primaryColor,
  );
}


