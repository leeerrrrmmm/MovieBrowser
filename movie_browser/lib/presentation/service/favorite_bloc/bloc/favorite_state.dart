part of 'favorite_bloc.dart';

/// [FavoriteState]
class FavoriteState {}

/// [FavoriteState]
class FavoriteInitial extends FavoriteState {}

/// [FavoriteLoading]
class FavoriteLoading extends FavoriteState {
  /// properties of [FavoriteLoading]
  final List<MovieEntity>? movies;

  /// Constructor of [FavoriteLoading]
  FavoriteLoading(this.movies);
}
