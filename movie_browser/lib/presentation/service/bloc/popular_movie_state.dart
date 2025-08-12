part of 'popular_movie_bloc.dart';

/// [PopularMovieState]

class PopularMovieState {}

///
class PopularMovieInitial extends PopularMovieState {}

///
class PopularMovieLoading extends PopularMovieState {}

///
class PopularMovieLoaded extends PopularMovieState {
  ///
  final List<MovieEntity> movies;

  ///
  PopularMovieLoaded({required this.movies});
}

///
class PopularMovieError extends PopularMovieState {
  ///
  final String message;

  ///
  PopularMovieError({required this.message});
}
