import 'package:flutter/material.dart';

TextStyle myInputTextStyle() => TextStyle(color: Colors.white70, fontSize: 18);

TextStyle myButtonTextStyle() => TextStyle(color: Colors.white70, fontSize: 20);

TextStyle myForgetPasswordTextStyle() =>
    TextStyle(color: Colors.white54, fontSize: 15);

TextStyle myHomeTitleTextStyle() =>
    TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold);

TextStyle myHomeCategoriesTextStyle() => myHomeTitleTextStyle()
    .copyWith(fontWeight: FontWeight.normal);

TextStyle myListTitleTextStyle() =>
    TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold);

TextStyle myListSubtitleTextStyle() =>
    TextStyle(color: Colors.white70, fontSize: 16);
