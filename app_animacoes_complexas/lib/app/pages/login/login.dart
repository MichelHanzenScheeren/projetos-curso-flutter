import 'package:appanimacoescomplexas/app/pages/login/loginForm.dart';
import 'package:appanimacoescomplexas/app/widgets/gradientContainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //timeDilation = 5;
    return Scaffold(
      body: GradientContainer(
        child: Center(
          child: SingleChildScrollView(
            child: LoginForm(controller),
          ),
        ),
      ),
    );
  }
}
