import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/data/model/movie_model.dart';
import 'package:movie_browser/presentation/service/favorite_bloc/bloc/favorite_bloc.dart';

/// [FavoriteScreen]
class FavoriteScreen extends StatefulWidget {
  /// Constructor for [FavoriteScreen]
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (_, state) {
          if (state is FavoriteInitial) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FavoriteInitial) {
            return const Center(child: Text('No favorites yet!'));
          }
          if (state is FavoriteLoading) {
            return ListView.builder(
              itemCount: state.movies?.length ?? 0,
              itemBuilder: (context, index) {
                final movie =
                    state.movies?[index] ??
                    const MovieModel(
                      originalTitle: 'Unknown',
                      overview: 'No overview available',
                      posterPath: 'No poster available',
                      releaseDate: 'No release date',
                    );

                return ListTile(
                  title: Text(movie.originalTitle),
                  subtitle: Text(movie.overview),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context.read<FavoriteBloc>().add(
                        RemoveFavoriteEvent(movie),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Unknown state'));
        },
      ),
    );
  }
}
