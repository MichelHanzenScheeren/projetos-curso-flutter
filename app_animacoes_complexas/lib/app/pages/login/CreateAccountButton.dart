import 'package:appanimacoescomplexas/app/themes/myTheme.dart';
import 'package:flutter/material.dart';

class CreateAccountButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        "Ainda não possui conta?",
        style: myButtonTextStyle().copyWith(fontSize: 18),
        textAlign: TextAlign.center,
      ),
    );
  }
}
