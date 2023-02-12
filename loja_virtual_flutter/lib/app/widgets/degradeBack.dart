import 'package:flutter/material.dart';

class DegradeBack extends StatelessWidget {
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;
  DegradeBack(this.colors, this.begin, this.end);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: begin,
          end: end,
        ),
      ),
    );
  }
}
