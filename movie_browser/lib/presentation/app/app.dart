import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/data/data_source/fetch_movie_data_source.dart';
import 'package:movie_browser/data/repo_impl/movie_repo_impl.dart';
import 'package:movie_browser/domain/use_case/fetch_movie_use_case.dart';
import 'package:movie_browser/presentation/navigation/custom_bottom_nav_bar.dart';
import 'package:movie_browser/presentation/service/favorite_bloc/bloc/favorite_bloc.dart';
import 'package:movie_browser/presentation/service/popular_bloc/popular_movie_bloc.dart';

/// [App]
class App extends StatelessWidget {
  /// [App] constructor
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final movieRepo = MovieRepoImpl(FetchMovieDataSource());
    final fetchMovieUseCase = FetchMovieUseCase(movieRepo);

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => PopularMovieBloc(fetchMovieUseCase: fetchMovieUseCase),
        ),
        BlocProvider(create: (_) => FavoriteBloc()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: CustomBottomNavBar(),
      ),
    );
  }
}
