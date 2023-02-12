import 'package:flutter/cupertino.dart';

class ToDoItem {
  String title;
  String subtitle;
  EdgeInsets margin;

  ToDoItem({
    @required this.title,
    @required this.subtitle,
    @required this.margin,
  });
}
