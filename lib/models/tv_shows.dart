class TVShows {
  final String name;
  final String backDropPath;
  final String originalName;
  final String overview;
  final String posterPath;
  final String firstAirDate;
  final double voteAverage;
  final int id; 

  TVShows({
    required this.name,
    required this.backDropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.firstAirDate,
    required this.voteAverage,
    required this.id, 
  });

  factory TVShows.fromJson(Map<String, dynamic> json) {
    return TVShows(
      id: json["id"] ?? 0, 
      name: json["name"] ?? '', 
      backDropPath: json["backdrop_path"] ?? '', 
      originalName: json["original_name"] ?? '', 
      overview: json["overview"] ?? '', 
      posterPath: json["poster_path"] ?? '', 
      firstAirDate: json["first_air_date"] ?? '', 
      voteAverage: (json["vote_average"] ?? 0.0).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "backdrop_path": backDropPath,
      "original_name": originalName,
      "overview": overview,
      "poster_path": posterPath,
      "first_air_date": firstAirDate,
      "vote_average": voteAverage,
    };
  }
}
