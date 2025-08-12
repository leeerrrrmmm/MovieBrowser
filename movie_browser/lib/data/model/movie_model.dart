import 'package:movie_browser/domain/entity/movie_entity.dart';

///[MovieModel]
class MovieModel extends MovieEntity {
  /// Constructor of [MovieModel]
  const MovieModel({
    required super.posterPath,
    required super.originalTitle,
    required super.overview,
    required super.releaseDate,
  });

  /// factory method
  factory MovieModel.fromJsom(Map<String, dynamic> json) => MovieModel(
    posterPath: json['poster_path'].toString(),
    originalTitle: json['title'].toString(),
    overview: json['overview'].toString(),
    releaseDate: json['release_date'].toString(),
  );
}
