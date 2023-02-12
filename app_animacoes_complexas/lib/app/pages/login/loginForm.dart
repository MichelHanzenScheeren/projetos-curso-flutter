import 'package:appanimacoescomplexas/app/pages/home/home.dart';
import 'package:appanimacoescomplexas/app/pages/login/CreateAccountButton.dart';
import 'package:appanimacoescomplexas/app/pages/login/forgetPasswordButton.dart';
import 'package:appanimacoescomplexas/app/pages/login/loginButton.dart';
import 'package:appanimacoescomplexas/app/pages/login/loginFormField.dart';
import 'package:appanimacoescomplexas/app/validators/passwordValidate.dart';
import 'package:appanimacoescomplexas/app/validators/usernameValidate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginForm extends StatelessWidget {
  final AnimationController controller;
  LoginForm(this.controller);

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void doLogin() => applyLogin(context);

    return Form(
      key: formKey,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Container(
            width: 320,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_pin, size: 160),
                SizedBox(height: 10),
                LoginFormField(
                  text: "Username",
                  icon: Icons.person_outline,
                  validator: usernameValidate,
                  controller: usernameController,
                ),
                SizedBox(height: 10),
                LoginFormField(
                  text: "Password",
                  icon: Icons.lock_outline,
                  controller: passwordController,
                  obscureTextControl: true,
                  validator: passwordValidate,
                ),
                ForgetPasswordButton(),
                SizedBox(height: 160)
              ],
            ),
          ),
          Column(
            children: <Widget>[
              LoginButton(doLogin, controller),
              CreateAccountButton(),
            ],
          ),
        ],
      ),
    );
  }

  void applyLogin(BuildContext context) {
    if (formKey.currentState.validate()) {
      controller.forward();
      controller.addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Home(username: usernameController.text),
          ));
        }
      });
    } else {}
  }
}
