import 'package:appanimacoescomplexas/app/pages/home/widgets/animatedListView.dart';
import 'package:appanimacoescomplexas/app/pages/home/widgets/fadeContainer.dart';
import 'package:appanimacoescomplexas/app/pages/home/widgets/homeTop.dart';
import 'package:appanimacoescomplexas/app/widgets/gradientContainer.dart';
import 'package:flutter/material.dart';

class StaggerAnimation extends StatelessWidget {
  final AnimationController controller;
  final String username;
  final Animation<double> curvedAnimation;
  final Animation<EdgeInsets> positionAnimation;
  final Animation<Color> fadeAnimation;
  StaggerAnimation({@required this.controller, @required this.username})
      : curvedAnimation = CurvedAnimation(
          parent: controller,
          curve: Interval(0.4, 1.0, curve: Curves.ease),
        ),
        positionAnimation = EdgeInsetsTween(
                begin: EdgeInsets.only(bottom: 0),
                end: EdgeInsets.only(bottom: 90))
            .animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.4, 1, curve: Curves.ease),
          ),
        ),
        fadeAnimation = ColorTween(
          begin: Color.fromRGBO(76, 43, 136, 1),
          end: Color.fromRGBO(76, 43, 136, 0),
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: Interval(0.0, 0.5, curve: Curves.slowMiddle),
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GradientContainer(
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    HomeTop(animation: curvedAnimation, username: username),
                    AnimatedListView(animation: positionAnimation),
                  ],
                ),
                IgnorePointer(child: FadeContainer(animation: fadeAnimation)),
              ],
            );
          },
        ),
      ),
    );
  }
}
