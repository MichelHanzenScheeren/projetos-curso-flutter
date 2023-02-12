import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosdoyoutubs/app/blocs/favoritesBloc.dart';
import 'package:favoritosdoyoutubs/app/blocs/videosBloc.dart';
import 'package:favoritosdoyoutubs/app/pages/homePage/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreateApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: VideosBloc(),
      child: BlocProvider(
        bloc: FavoritesBloc(),
        child: MaterialApp(
          title: 'Favoritoss do Youtube',
          home: Home(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.grey,
            primaryIconTheme: IconThemeData(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
