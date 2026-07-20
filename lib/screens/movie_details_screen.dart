import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../models/movie.dart';
import '../services/tmdb_service.dart';
import '../theme/app_theme.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final TmdbService _tmdb = TmdbService();
  Movie? _details;
  String? _trailerKey;
  YoutubePlayerController? _ytController;

  @override
  void initState() {
    super.initState();
    _loadDetails();
  }

  Future<void> _loadDetails() async {
    final details = await _tmdb.getMovieDetails(widget.movie.id);
    final trailer = await _tmdb.getTrailerKey(widget.movie.id);
    if (!mounted) return;
    if (trailer != null) {
      _ytController = YoutubePlayerController.fromVideoId(
        videoId: trailer,
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          enableCaption: true,
        ),
      );
    }
    setState(() {
      _details = details ?? widget.movie;
      _trailerKey = trailer;
    });
  }

  @override
  void dispose() {
    _ytController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final m = _details ?? widget.movie;
    return Scaffold(
      backgroundColor: AppTheme.background,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: 480,
                  child: CachedNetworkImage(
                    imageUrl: m.backdropUrl,
                    fit: BoxFit.cover,
                    errorWidget: (_, __, ___) => Container(color: AppTheme.cardBg),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 480,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        AppTheme.background,
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
                  left: 30,
                  child: SafeArea(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                ),
                Positioned(
                  left: 60,
                  bottom: 30,
                  child: SizedBox(
                    width: 600,
                    child: Text(
                      m.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: m.posterUrl,
                      width: 240,
                      height: 360,
                      fit: BoxFit.cover,
                      errorWidget: (_, __, ___) => Container(
                        color: AppTheme.cardBg,
                        width: 240,
                        height: 360,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.star, color: AppTheme.accentGold, size: 26),
                            const SizedBox(width: 6),
                            Text(
                              '${m.rating.toStringAsFixed(1)}/5',
                              style: const TextStyle(
                                color: AppTheme.accentGold,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 20),
                            if (m.releaseDate.isNotEmpty)
                              Text(
                                '📅 ${m.releaseDate}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 18,
                                ),
                              ),
                            const SizedBox(width: 20),
                            Text(
                              '👥 ${m.voteCount} votos',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          '📖 Sinopse',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          m.overview.isNotEmpty
                              ? m.overview
                              : 'Sinopse não disponível em português.',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (_trailerKey != null && _ytController != null) ...[
                          const Text(
                            '🎬 Trailer',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: YoutubePlayer(
                              controller: _ytController!,
                            ),
                          ),
                        ] else if (_details != null) ...[
                          Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: AppTheme.cardBg,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.info_outline, color: Colors.white54, size: 30),
                                SizedBox(width: 14),
                                Expanded(
                                  child: Text(
                                    'Trailer não disponível no momento. Use um serviço de streaming para assistir.',
                                    style: TextStyle(color: Colors.white70, fontSize: 15),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
