class Movie {
  final String title;
  final String backDropPath;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;
  final int id; 

  Movie({
    required this.id, 
    required this.title,
    required this.backDropPath,
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json["id"] ?? 0, 
      title: json["title"] ?? '', 
      backDropPath: json["backdrop_path"] ?? '', 
      originalTitle: json["original_title"] ?? '', 
      overview: json["overview"] ?? '', 
      posterPath: json["poster_path"] ?? '', 
      releaseDate: json["release_date"] ?? '', 
      voteAverage: (json["vote_average"] ?? 0.0).toDouble(), 
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "title": title,
      "backdrop_path": backDropPath,
      "original_title": originalTitle,
      "overview": overview,
      "poster_path": posterPath,
      "release_date": releaseDate,
      "vote_average": voteAverage,
    };
  }
}

