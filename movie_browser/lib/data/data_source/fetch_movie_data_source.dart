import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_browser/data/model/movie_model.dart';

/// [FetchMovieDataSource]
class FetchMovieDataSource {
  /// TMDB api key
  final String apiKey = dotenv.env['TMDB_KEY'] ?? '';

  /// TMDB base Url
  final String url = 'https://api.themoviedb.org/3/movie/popular';

  /// [successKey]
  static const int successKey = 200;

  ///
  Future<List<MovieModel>> fetchPosts() async {
    final response = await http.get(
      Uri.parse('$url?api_key=$apiKey&language=en-US&page=1'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
      },
    );

    if (response.statusCode == successKey) {
      final decoded = json.decode(response.body) as Map<String, dynamic>;
      final results = decoded['results'] as List;
      // log('Response: ${response.body}');
      log('Statuc code: ${response.statusCode}');

      return results
          .map((el) => MovieModel.fromJsom(el as Map<String, dynamic>))
          .toList();
    } else {
      log('Error: ${response.statusCode}');
      throw Exception('Failed to load posts: ${response.statusCode}');
    }
  }
}
