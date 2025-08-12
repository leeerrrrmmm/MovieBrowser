import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_browser/presentation/service/bloc/popular_movie_bloc.dart';

/// [MainScreen]
class MainScreen extends StatefulWidget {
  ///
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    super.initState();
    context.read<PopularMovieBloc>().add(LoadPopularMovies());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Popular Movies')),
      body: BlocBuilder<PopularMovieBloc, PopularMovieState>(
        builder: (_, state) {
          if (state is PopularMovieInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is PopularMovieError) {
            return Center(
              child: Text(
                "Error loading movies:\n${state.message}",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          if (state is PopularMovieLoaded) {
            final movies = state.movies;

            if (movies.isEmpty) {
              return const Center(child: Text("No movies available"));
            }

            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (_, index) {
                final movie = movies[index];

                return Card(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Картинка фильма
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: movie.posterPath.isNotEmpty
                              ? Image.network(
                                  imageBaseUrl + movie.posterPath,
                                  width: 100,
                                  height: 150,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) => const Icon(
                                    Icons.broken_image,
                                    size: 100,
                                    color: Colors.grey,
                                  ),
                                )
                              : const SizedBox(
                                  width: 100,
                                  height: 150,
                                  child: Icon(
                                    Icons.movie,
                                    size: 60,
                                    color: Colors.grey,
                                  ),
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                movie.overview,
                                maxLines: 5,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(child: Text("No movies available"));
        },
      ),
    );
  }
}
