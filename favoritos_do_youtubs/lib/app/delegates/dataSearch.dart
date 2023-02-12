import 'package:favoritosdoyoutubs/app/controllers/youtubeApi.dart';
import 'package:favoritosdoyoutubs/app/models/suggestion.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    Future.delayed(Duration.zero).then((_) => close(context, query));
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) return Container();
    return FutureBuilder<List<Suggestion>>(
      future: YoutubeApi().suggestions(query),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: ListView(
            children: snapshot.data.map((suggestion) {
              return ListTile(
                leading: Icon(Icons.search),
                title: Text(suggestion.text),
                onTap: () {
                  close(context, suggestion.text);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
