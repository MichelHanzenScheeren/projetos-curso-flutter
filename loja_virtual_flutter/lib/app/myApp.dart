import 'package:flutter/material.dart';
import 'package:lojavirtualflutter/app/controllers/user.dart';
import 'package:lojavirtualflutter/app/pages/controllerPages.dart';
import 'package:scoped_model/scoped_model.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<User>(
      model: User(),
      child: MaterialApp(
        title: 'Lojinha do Mixéu',
        debugShowCheckedModeBanner: false,
        home: ControllerPage(),
        theme: ThemeData(
          scaffoldBackgroundColor: Color.fromARGB(240, 30, 30, 30),
          primaryColor: Color.fromARGB(255, 60, 60, 60),
          hintColor: Color.fromARGB(230, 230, 230, 230),
          iconTheme: IconThemeData(
            color: Color.fromARGB(240, 230, 230, 230),
            size: 32,
          ),
          disabledColor: Color.fromARGB(130, 130, 130, 130),
          dividerTheme: DividerThemeData(color: Colors.grey[700]),
          textTheme: TextTheme(
            title: TextStyle(
              color: Color.fromARGB(255, 245, 245, 245),
              fontSize: 36,
              fontWeight: FontWeight.bold,
            ),
            subtitle: TextStyle(
              color: Color.fromARGB(245, 240, 240, 240),
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            body1: TextStyle(
              color: Color.fromARGB(245, 225, 225, 225),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
            body2: TextStyle(
              color: Colors.indigoAccent,
              fontSize: 22,
            ),
            subhead: TextStyle(
              color: Color.fromARGB(220, 220, 220, 220),
              fontSize: 25,
            ),
            display1: TextStyle(
              color: Color.fromARGB(220, 220, 220, 220),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            display2: TextStyle(
              color: Colors.indigoAccent,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
