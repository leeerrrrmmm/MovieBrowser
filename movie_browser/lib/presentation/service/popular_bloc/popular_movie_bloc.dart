import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/domain/entity/movie_entity.dart';
import 'package:movie_browser/domain/use_case/fetch_movie_use_case.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

///
class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  ///
  final FetchMovieUseCase fetchMovieUseCase;

  /// Constructor for [PopularMovieBloc]
  PopularMovieBloc({required this.fetchMovieUseCase})
    : super(PopularMovieInitial()) {
    on<LoadPopularMovies>((_, emit) async {
      emit(PopularMovieLoading());
      try {
        final movies = await fetchMovieUseCase();
        emit(PopularMovieLoaded(movies: movies));
      } catch (e) {
        emit(PopularMovieError(message: e.toString()));
      }
    });
  }
}
