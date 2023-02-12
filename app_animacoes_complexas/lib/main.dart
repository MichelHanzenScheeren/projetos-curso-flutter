import 'package:appanimacoescomplexas/app/pages/login/login.dart';
import 'package:appanimacoescomplexas/app/themes/appTheme.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Animações Complexas',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      home: Login(),
    );
  }
}
