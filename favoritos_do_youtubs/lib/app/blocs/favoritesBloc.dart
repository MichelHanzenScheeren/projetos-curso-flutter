import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosdoyoutubs/app/models/video.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesBloc implements BlocBase {
  List<Video> _favorites = List<Video>();

  final _favoritesController = BehaviorSubject<List<Video>>();
  Stream<List<Video>> get outFavorites => _favoritesController.stream;

  FavoritesBloc() {
    _favoritesController.add([]);

    SharedPreferences.getInstance().then((preference) {
      if(preference.getKeys().contains("favorites")){
        _favorites = json.decode(preference.getString("favorites")).map<Video>((item) {
          return Video.fromJson(item);
        }).toList();
        _favoritesController.add(_favorites);
      }
    });
  }

  void toggleFavorite(Video video) {
    if(_favorites.contains(video)) _favorites.remove(video);
    else _favorites.add(video);

    _favoritesController.sink.add(_favorites);
    _saveFavorites();
  }

  void _saveFavorites() async {
    SharedPreferences.getInstance().then((preference) {
       preference.setString("favorites", json.encode(_favorites));
    });
  }



  @override
  void dispose() {
    _favoritesController.close();
  }

}