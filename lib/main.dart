import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:newsfeed/store/database/database_state.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'constants/db_constants.dart';
import 'navigator/router.gr.dart';
import 'network/dio.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton(dio);
  runApp(MyApp());
  registerDatabaseState();
}

Future<void> registerDatabaseState() async {
  GetIt.I.registerSingleton(DatabaseState());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (ctx, nativeNavigator) =>
            ExtendedNavigator<Router>(router: Router()));
  }
}
