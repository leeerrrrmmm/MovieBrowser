import 'package:flutter/material.dart';
import 'package:movie_browser/domain/entity/movie_entity.dart';

/// [DetailScreen]
class DetailScreen extends StatelessWidget {
  /// property for movie detail
  final MovieEntity movie;

  /// Constructor for [DetailScreen]
  const DetailScreen({required this.movie, super.key});

  /// Base URL for movie poster
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  Widget build(BuildContext context) {
    final posterUrl = movie.posterPath.isNotEmpty
        ? imageBaseUrl + movie.posterPath
        : null;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Add to Favorites',
            onPressed: () {
              // TODO: добавить логику добавления в понравившиеся
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Добавлено в понравившиеся')),
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
              movie.originalTitle,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              'Release date: ${movie.releaseDate}',
              style: const TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            Text(movie.overview, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
