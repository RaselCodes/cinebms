class Movie {
  String _title='';
  String _releaseYear='';
  String _synopsis='';
  String _posterUri='';

  Movie({required String title, required String releaseYear, required String synopsis, required String posterUri}) {
    _title = title;
    _releaseYear = releaseYear;
    _synopsis = synopsis;
    _posterUri = posterUri;
  }

  String getTitle() {
    return _title;
  }
  void setTitle(String title) {
    _title = title;
  }
  String getReleaseYear() {
    return _releaseYear;
  }
  void setReleaseYear(String releaseYear) {
    _releaseYear = releaseYear;
  }
  String getSynopsis() {
    return _synopsis;
  }
  void setSynopsis(String synopsis) {
    _synopsis = synopsis;
  }
  String getPosterUri() {
    return _posterUri;
  }
  void setPosterUri(String posterUri) {
    _posterUri = posterUri;
  }

  Movie.fromJson(Map<String, dynamic> json) {
    _title = json['title'];
    _releaseYear = json['release-year'];
    _synopsis = json['synopsis'];
    _posterUri = json['poster-uri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = _title;
    data['release-year'] = _releaseYear;
    data['synopsis'] = _synopsis;
    data['poster-uri'] = _posterUri;
    return data;
  }
}
