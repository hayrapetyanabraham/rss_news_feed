import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:background_fetch/background_fetch.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
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