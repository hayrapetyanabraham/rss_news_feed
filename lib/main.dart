import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'navigator/router.gr.dart';
import 'network/dio.dart';

GetIt getIt = GetIt.instance;

void main() {
  getIt.registerSingleton(dio);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (ctx, nativeNavigator) =>
            ExtendedNavigator<Router>(router: Router()));
  }
}
