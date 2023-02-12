class Suggestion {
  String text;

  Suggestion.fromJson(dynamic json) {
    text = json[0];
  }
}
