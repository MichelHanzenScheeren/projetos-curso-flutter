import 'package:appanimacoescomplexas/app/pages/home/widgets/staggerAnimation.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final String username;
  Home({@required this.username});
  @override
  _HomeState createState() => _HomeState(username);
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final String username;
  AnimationController controller;
  _HomeState(this.username);

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StaggerAnimation(controller: controller.view, username: username);
  }
}
