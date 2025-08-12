import 'package:movie_browser/data/data_source/fetch_movie_data_source.dart';
import 'package:movie_browser/domain/entity/movie_entity.dart';
import 'package:movie_browser/domain/repo/movie_repo.dart';

/// [MovieRepoImpl]
class MovieRepoImpl extends MovieRepo {
  ///
  final FetchMovieDataSource fetchMovieDataSource;

  /// Constructor of [MovieRepoImpl]
  MovieRepoImpl(this.fetchMovieDataSource);

  @override
  Future<List<MovieEntity>> fetchMovies() {
    return fetchMovieDataSource.fetchPosts();
  }
}
