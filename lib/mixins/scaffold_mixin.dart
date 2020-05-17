import 'package:flutter/material.dart';

mixin ScaffoldMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    GlobalKey<ScaffoldState> context, {
    String text,
    Color color,
  }) {
    return scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        content: Container(
          height: 50.0,
          color: color,
          margin: EdgeInsets.only(bottom: 70),
          child: Center(
              child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          )),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  }
}
