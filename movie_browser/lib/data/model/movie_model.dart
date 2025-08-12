import 'package:movie_browser/domain/entity/movie_entity.dart';

/// [MovieModel]
class MovieModel extends MovieEntity {
  /// Constructor for [MovieModel]
  const MovieModel({
    required super.originalTitle,
    required super.overview,
    required super.posterPath,
    required super.releaseDate,
  });

  ///
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      originalTitle: json['original_title'] as String,
      overview: json['overview'] as String,
      posterPath: json['poster_path'] as String,
      releaseDate: json['release_date'] as String,
    );
  }
}
