import 'package:flutter/material.dart';

class MyUserTerms extends StatelessWidget {
  final TextStyle style;
  MyUserTerms(this.style);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: RichText(
        text: TextSpan(
          text: "Ao se cadastrar, você declara que leu e aceitou os ",
          style: style.copyWith(fontSize: 15),
          children: <TextSpan>[
            TextSpan(
              text: "termos de uso",
              style: style.copyWith(
                fontSize: 15,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(
              text: " e a ",
              style: style.copyWith(fontSize: 15),
            ),
            TextSpan(
              text: "política de usuários.",
              style: style.copyWith(
                fontSize: 15,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
