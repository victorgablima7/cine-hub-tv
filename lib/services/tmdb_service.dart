import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';

class TmdbService {
  // Chave de demonstração — recomenda-se trocar pela sua em Configurações
  static const String _demoApiKey = 'b89a2e8b1c0e5b8c8e8e8e8e8e8e8e8e';
  static const String _baseUrl = 'https://api.themoviedb.org/3';
  static const String _language = 'pt-BR';

  String _apiKey;

  TmdbService({String? apiKey}) : _apiKey = apiKey ?? _demoApiKey;

  Future<void> initApiKey() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedKey = prefs.getString('tmdb_api_key');
      if (savedKey != null && savedKey.isNotEmpty) {
        _apiKey = savedKey;
      }
    } catch (e) {
      print('Erro ao carregar API key: $e');
    }
  }

  void updateApiKey(String newKey) {
    _apiKey = newKey;
  }

  String get currentKey => _apiKey;
  bool get isUsingDemoKey => _apiKey == _demoApiKey;

  Future<List<Movie>> getTrending() async {
    final url = Uri.parse(
        '$_baseUrl/trending/movie/week?api_key=$_apiKey&language=$_language');
    return _fetchMovies(url);
  }

  Future<List<Movie>> getPopular() async {
    final url = Uri.parse(
        '$_baseUrl/movie/popular?api_key=$_apiKey&language=$_language&page=1');
    return _fetchMovies(url);
  }

  Future<List<Movie>> getTopRated() async {
    final url = Uri.parse(
        '$_baseUrl/movie/top_rated?api_key=$_apiKey&language=$_language&page=1');
    return _fetchMovies(url);
  }

  Future<List<Movie>> getNowPlaying() async {
    final url = Uri.parse(
        '$_baseUrl/movie/now_playing?api_key=$_apiKey&language=$_language&page=1');
    return _fetchMovies(url);
  }

  Future<List<Movie>> getUpcoming() async {
    final url = Uri.parse(
        '$_baseUrl/movie/upcoming?api_key=$_apiKey&language=$_language&page=1');
    return _fetchMovies(url);
  }

  Future<List<Movie>> getByGenre(int genreId) async {
    final url = Uri.parse(
        '$_baseUrl/discover/movie?api_key=$_apiKey&language=$_language&with_genres=$genreId&sort_by=popularity.desc&page=1');
    return _fetchMovies(url);
  }

  Future<List<Movie>> searchMovies(String query) async {
    if (query.trim().isEmpty) return [];
    final url = Uri.parse(
        '$_baseUrl/search/movie?api_key=$_apiKey&language=$_language&query=${Uri.encodeComponent(query)}&page=1');
    return _fetchMovies(url);
  }

  Future<Movie?> getMovieDetails(int movieId) async {
    final url = Uri.parse(
        '$_baseUrl/movie/$movieId?api_key=$_apiKey&language=$_language');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return Movie.fromJson(json.decode(response.body));
      }
    } catch (e) {
      print('Erro ao buscar detalhes: $e');
    }
    return null;
  }

  Future<String?> getTrailerKey(int movieId) async {
    final url = Uri.parse(
        '$_baseUrl/movie/$movieId/videos?api_key=$_apiKey&language=$_language');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List? ?? [];
        // prioriza trailer oficial do YouTube
        final trailer = results.firstWhere(
          (v) =>
              v['site'] == 'YouTube' &&
              (v['type'] == 'Trailer' || v['type'] == 'Teaser'),
          orElse: () => null,
        );
        if (trailer != null) return trailer['key'] as String;
        // fallback: qualquer vídeo do YouTube
        if (results.isNotEmpty && results.first['site'] == 'YouTube') {
          return results.first['key'] as String;
        }
      }
    } catch (e) {
      print('Erro ao buscar trailer: $e');
    }
    return null;
  }

  Future<List<Movie>> _fetchMovies(Uri url) async {
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List? ?? [];
        return results.map((j) => Movie.fromJson(j)).toList();
      }
    } catch (e) {
      print('Erro TMDB: $e');
    }
    return [];
  }
}
