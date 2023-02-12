import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritosdoyoutubs/app/controllers/youtubeApi.dart';
import 'package:favoritosdoyoutubs/app/models/video.dart';

class VideosBloc implements BlocBase {
  YoutubeApi _youtubeApi;
  List<Video> videos;

  final _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  VideosBloc() {
    _youtubeApi = YoutubeApi();
    _searchController.stream.listen(_search);
    inSearch.add(null);
  }

  void _search(String search) async {
    if(search == null || search.isNotEmpty) {
      _videosController.sink.add([]);
      videos = await _youtubeApi.search(search);
    } else {
      videos += await _youtubeApi.nextPageSearch();
    }
    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
