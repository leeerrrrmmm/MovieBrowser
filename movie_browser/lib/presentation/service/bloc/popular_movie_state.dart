part of 'popular_movie_bloc.dart';

///
class PopularMovieState {}

///
class PopularMovieInitial extends PopularMovieState {}

///
class PopularMovieLoading extends PopularMovieState {
  ///
  final List<MovieEntity>? movies;

  ///
  PopularMovieLoading({this.movies = const []});
}

///
class PopularMovieError extends PopularMovieState {
  ///
  final String message;

  ///
  PopularMovieError({required this.message});
}
