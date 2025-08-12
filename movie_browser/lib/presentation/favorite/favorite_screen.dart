import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/presentation/service/favorite_bloc/bloc/favorite_bloc.dart';

/// [FavoriteScreen]
class FavoriteScreen extends StatefulWidget {
  /// Constructor for [FavoriteScreen]
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  // Базовый URL для постера
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    super.initState();
    context.read<FavoriteBloc>().add(LoadFavoriteMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (_, state) {
          if (state is FavoriteInitial) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }

          if (state is FavoriteLoading) {
            final movies = state.movies ?? [];

            if (movies.isEmpty) {
              return const Center(
                child: Text('Поки що немає сподобаних фільмів'),
              );
            }

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                final posterUrl = movie.posterPath.isNotEmpty
                    ? imageBaseUrl + movie.posterPath
                    : null;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (posterUrl != null)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            posterUrl,
                            width: 80,
                            height: 120,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => const Icon(
                              Icons.broken_image,
                              size: 80,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      else
                        Container(
                          width: 80,
                          height: 120,
                          color: Colors.grey.shade300,
                          child: const Icon(
                            Icons.movie,
                            size: 50,
                            color: Colors.white70,
                          ),
                        ),
                      const SizedBox(width: 12),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie.originalTitle,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              movie.overview,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black87,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),

                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.redAccent),

                        onPressed: () {
                          context.read<FavoriteBloc>().add(
                            RemoveFavoriteEvent(movie),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${movie.originalTitle} видалено з сподобаних',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return const Center(child: Text('Неизвестное состояние'));
        },
      ),
    );
  }
}
