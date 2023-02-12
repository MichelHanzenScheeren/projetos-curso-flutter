import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosdoyoutubs/app/api.dart';
import 'package:favoritosdoyoutubs/app/blocs/favoritesBloc.dart';
import 'package:favoritosdoyoutubs/app/models/video.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';

class FavoritesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favBloc = BlocProvider.of<FavoritesBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        title: Text(
          "Favoritos",
          style: TextStyle(color: Colors.white, fontSize: 22),
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black54,
      body: StreamBuilder<List<Video>>(
        stream: favBloc.outFavorites,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return myListView(snapshot.data, favBloc);
          }
        },
      ),
    );
  }

  Widget myListView(List<Video> data, favBloc) {
    return ListView(
      children: data.map((item) {
        return Column(
          children: <Widget>[
            Dismissible(
              key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
              background: Container(
                color: Colors.red,
                child: Align(
                    alignment: Alignment(-0.9, 0.0),
                    child: Icon(
                      Icons.delete,
                      color: Colors.white,
                    )),
              ),
              direction: DismissDirection.horizontal,
              onDismissed: (direction) {
                favBloc.toggleFavorite(item);
              },
              child: InkWell(
                onTap: () {
                  FlutterYoutube.playYoutubeVideoById(
                      apiKey: API_KEY, videoId: item.id);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 120,
                      height: 68,
                      child: Image.network(item.thumb, fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              item.title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              item.channel,
                              style: TextStyle(
                                color: Colors.grey[500],
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Divider(color: Colors.grey),
          ],
        );
      }).toList(),
    );
  }
}
