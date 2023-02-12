import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/pages/user/createAccount/createAccount.dart';

class MyCreateAccountButton extends StatelessWidget {
  final TextStyle style;
  MyCreateAccountButton(this.style);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => CreateAccount()));
      },
      child: Column(
        children: <Widget>[
          Text(
            "Não possui conta?",
            textAlign: TextAlign.center,
            style: style.copyWith(fontSize: 16),
          ),
          Text(
            "Crie agora mesmo",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.white,
                fontSize: 18),
          )
        ],
      ),
    );
  }
}
