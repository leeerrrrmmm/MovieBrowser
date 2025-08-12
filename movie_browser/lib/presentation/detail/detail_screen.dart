import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/domain/entity/movie_entity.dart';
import 'package:movie_browser/presentation/service/favorite_bloc/bloc/favorite_bloc.dart';

/// [DetailScreen]
class DetailScreen extends StatefulWidget {
  /// property for movie detail
  final MovieEntity movie;

  /// Constructor for [DetailScreen]
  const DetailScreen({required this.movie, super.key});

  /// Base URL for movie poster
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    final posterUrl = widget.movie.posterPath.isNotEmpty
        ? DetailScreen.imageBaseUrl + widget.movie.posterPath
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        actions: [
          BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              // Отримуэмо список улюблених фільмів
              final favoriteMovies = <MovieEntity>[];

              // Якщо стан є FavoriteLoading, додаємо фільми до списку
              if (state is FavoriteLoading) {
                favoriteMovies.addAll(state.movies ?? []);
              }

              // Перевіряємо, чи фільм уже додано до улюблених
              final isAdded = favoriteMovies.any(
                (movie) => movie.originalTitle == widget.movie.originalTitle,
              );

              return IconButton(
                icon: isAdded
                    ? const Icon(Icons.favorite)
                    : const Icon(Icons.favorite_border),
                tooltip: isAdded
                    ? 'Видалити з сподобавшихся'
                    : 'Додати до сподобавшихся',
                onPressed: () {
                  if (isAdded) {
                    context.read<FavoriteBloc>().add(
                      RemoveFavoriteEvent(widget.movie),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Видалено з сподобавшихся')),
                    );
                  } else {
                    context.read<FavoriteBloc>().add(
                      AddFavoriteEvent(widget.movie),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Додано до сподобавшихся')),
                    );
                  }
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (posterUrl != null)
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    posterUrl,
                    height: 350,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(
                      Icons.broken_image,
                      size: 150,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            Text(
              widget.movie.originalTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Release date: ${widget.movie.releaseDate}',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(widget.movie.overview, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
