import 'package:movie_browser/domain/entity/movie_entity.dart';

/// [MovieRepo]
abstract class MovieRepo {
  /// Fetches a list of movies.
  Future<List<MovieEntity>> fetchMovies();
}
