import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/domain/entity/movie_entity.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

/// [FavoriteBloc]
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  /// properties of [FavoriteBloc]
  final List<MovieEntity> _favoriteMovies = [];

  /// Constructor of [FavoriteBloc]
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((_, emit) {
      emit(FavoriteLoading(List.from(_favoriteMovies)));
    });

    on<AddFavoriteEvent>((event, emit) {
      log('Додаємо фільм до обраного: ${event.movie.originalTitle}');
      _favoriteMovies.add(event.movie);
      log('Діюча кіл-сть фільмів в state: ${_favoriteMovies.length}');
      emit(FavoriteLoading(List.from(_favoriteMovies)));
    });
    on<RemoveFavoriteEvent>((event, emit) {
      log('Видаляємо фільм до обраного: ${event.movie.originalTitle}');
      _favoriteMovies.remove(event.movie);
      log('Діюча кіл-сть фільмів в state: ${_favoriteMovies.length}');
      emit(FavoriteLoading(List.from(_favoriteMovies)));
    });
  }
}
