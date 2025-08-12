import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/domain/entity/movie_entity.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

/// [FavoriteBloc]
class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final List<MovieEntity> _favoriteMovies = [];

  /// Contructor of [FavoriteBloc]
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((_, emit) {
      emit(FavoriteLoading(List.from(_favoriteMovies)));
    });

    on<AddFavoriteEvent>((event, emit) {
      log('Додаємо фільм до обраного: ${event.movie.originalTitle}');
      // Перевіряємо, чи фільм вже є в обраному
      final isAlreadyAdded = _favoriteMovies.any(
        (movie) => movie.originalTitle == event.movie.originalTitle,
      );

      if (!isAlreadyAdded) {
        _favoriteMovies.add(event.movie);
        log('Кількість фільмів після додавання: ${_favoriteMovies.length}');
      } else {
        log('Фільм вже в обраному, пропускаємо додавання');
      }
      emit(FavoriteLoading(List.from(_favoriteMovies)));
    });

    on<RemoveFavoriteEvent>((event, emit) {
      log('Видаляємо фільм з обраного: ${event.movie.originalTitle}');
      // Відиляємо фільм з обраного
      _favoriteMovies.removeWhere(
        (movie) => movie.originalTitle == event.movie.originalTitle,
      );
      log('Кількість фільмів після видалення: ${_favoriteMovies.length}');
      emit(FavoriteLoading(List.from(_favoriteMovies)));
    });
  }
}
