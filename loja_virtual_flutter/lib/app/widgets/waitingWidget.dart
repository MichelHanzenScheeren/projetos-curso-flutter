import 'package:flutter/material.dart';

class WaitingWidget extends StatelessWidget {
  final double width;
  final double height;
  final double strokeWidth;
  WaitingWidget({this.width: 150, this.height: 150, this.strokeWidth: 5});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
