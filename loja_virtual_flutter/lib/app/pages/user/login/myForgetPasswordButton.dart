import 'package:flutter/material.dart';

class MyForgetPasswordButton extends StatelessWidget {
  final TextStyle style;
  final Function forgetPassword;
  MyForgetPasswordButton(this.style, this.forgetPassword);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Text(
          "Esqueceu a senha?",
          textAlign: TextAlign.right,
          style: style.copyWith(
            fontSize: 15,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      onTap: forgetPassword,
    );
  }
}
