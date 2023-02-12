import 'dart:ui';

import 'package:flutter/material.dart';

class GradientContainer extends StatelessWidget {
  final Widget child;
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  GradientContainer({
    @required this.child,
    this.colors,
    this.begin: Alignment.topCenter,
    this.end: Alignment.bottomCenter,
  });

  @override
  Widget build(BuildContext context) {
    final patternColors = [
      Color.fromRGBO(11, 6, 9, 1),
      Color.fromRGBO(66, 33, 125, 1),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin,
          end: end,
          colors: colors ?? patternColors,
        ),
      ),
      child: child,
    );
  }
}
