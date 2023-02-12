import 'package:flutter/material.dart';

class FadeContainer extends StatelessWidget {
  final Animation<Color> animation;
  FadeContainer({@required this.animation});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "fade",
      child: Container(
        decoration: BoxDecoration(
          color: animation.value,
        ),
      ),
    );
  }
}
