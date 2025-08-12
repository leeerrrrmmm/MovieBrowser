part of 'favorite_bloc.dart';

/// [FavoriteEvent]
class FavoriteEvent {}

/// [LoadFavoriteMoviesEvent]
class LoadFavoriteMoviesEvent extends FavoriteEvent {
  /// Constructor for [LoadFavoriteMoviesEvent]
  LoadFavoriteMoviesEvent();
}

/// [AddFavoriteEvent]
class AddFavoriteEvent extends FavoriteEvent {
  /// properties of [AddFavoriteEvent]
  final MovieEntity movie;

  /// Constructor of [AddFavoriteEvent]
  AddFavoriteEvent(this.movie);
}

/// [RemoveFavoriteEvent]
class RemoveFavoriteEvent extends FavoriteEvent {
  /// properties of [RemoveFavoriteEvent]
  final MovieEntity movie;

  /// Constructor of [RemoveFavoriteEvent]
  RemoveFavoriteEvent(this.movie);
}
