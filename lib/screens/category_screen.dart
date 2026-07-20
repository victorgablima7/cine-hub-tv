import 'package:flutter/material.dart';
import '../models/genre.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../theme/app_theme.dart';
import '../widgets/movie_card.dart';
import 'movie_details_screen.dart';

class CategoryScreen extends StatefulWidget {
  final Genre genre;

  const CategoryScreen({super.key, required this.genre});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final TmdbService _tmdb = TmdbService();
  List<Movie> _movies = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final list = await _tmdb.getByGenre(widget.genre.id);
    if (mounted) {
      setState(() {
        _movies = list;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        title: Row(
          children: [
            Text(widget.genre.emoji, style: const TextStyle(fontSize: 26)),
            const SizedBox(width: 10),
            Text(
              widget.genre.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator(color: AppTheme.accent))
          : _movies.isEmpty
              ? const Center(
                  child: Text(
                    'Nenhum filme encontrado nesta categoria.',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(40),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 0.67,
                    crossAxisSpacing: 18,
                    mainAxisSpacing: 18,
                  ),
                  itemCount: _movies.length,
                  itemBuilder: (_, i) => MovieCard(
                    movie: _movies[i],
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => MovieDetailsScreen(movie: _movies[i]),
                      ),
                    ),
                    width: 200,
                    height: 300,
                  ),
                ),
    );
  }
}
