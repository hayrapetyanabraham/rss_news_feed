import 'package:flutter/material.dart';

class ShadowContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry margin;
  final double width;
  final double blurRadius;
  final BorderRadiusGeometry borderRadius;
  final Color shadowColor;

  const ShadowContainer({
    Key key,
    this.height,
    this.padding,
    this.margin,
    this.child,
    this.width,
    this.blurRadius,
    this.borderRadius,
    this.shadowColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              blurRadius: blurRadius,
              color: shadowColor,
            ),
          ]),
      child: child,
    );
  }
}
