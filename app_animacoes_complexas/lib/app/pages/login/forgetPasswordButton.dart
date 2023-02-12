import 'package:appanimacoescomplexas/app/themes/myTheme.dart';
import 'package:flutter/material.dart';

class ForgetPasswordButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(top: 5),
        child: Text(
          "Esqueceu sua senha?",
          style: myForgetPasswordTextStyle(),
          textAlign: TextAlign.right,
        ),
      ),
    );
  }
}
