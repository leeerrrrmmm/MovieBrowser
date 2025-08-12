/// [MovieEntity]
class MovieEntity {
  /// [originalTitle] property
  final String originalTitle;

  /// [overview] property
  final String overview;

  /// [posterPath] property
  final String posterPath;

  /// [releaseDate] property
  final String releaseDate;

  /// Constructor for [MovieEntity]
  const MovieEntity({
    required this.originalTitle,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
  });
}
