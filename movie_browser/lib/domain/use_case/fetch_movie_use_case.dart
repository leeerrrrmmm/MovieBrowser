import 'package:movie_browser/domain/entity/movie_entity.dart';
import 'package:movie_browser/domain/repo/movie_repo.dart';

/// [FetchMovieUseCase]
class FetchMovieUseCase {
  /// Repository for fetching movies.
  final MovieRepo movieRepo;

  /// Constructor for [FetchMovieUseCase]
  FetchMovieUseCase(this.movieRepo);

  /// Calls the repository to fetch movies.
  Future<List<MovieEntity>> call() {
    return movieRepo.fetchMovies();
  }
}
