class Video {
  String id;
  String title;
  String thumb;
  String channel;

  Video.fromJson(Map<String, dynamic> json) {
    if(json.containsKey("snippet")) {
      try{
        id = json["id"]["videoId"];
      } catch(_){
        id = json["id"];
      }
      title = json["snippet"]["title"];
      thumb = json["snippet"]["thumbnails"]["high"]["url"];
      channel = json["snippet"]["channelTitle"];
    } else {
      id = json["id"];
      title = json["title"];
      thumb = json["thumb"];
      channel = json["channel"];
    }
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "thumb": thumb,
      "channel": channel
    };
  }

  @override
  bool operator ==(other) {
    return other.id == this.id;
  }


}
