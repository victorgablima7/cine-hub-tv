class Genre {
  final int id;
  final String name;
  final String emoji;
  final int color;

  Genre({
    required this.id,
    required this.name,
    required this.emoji,
    required this.color,
  });
}

class Genres {
  static const List<Genre> all = [
    Genre(id: 28, name: 'Ação', emoji: '💥', color: 0xFFFF3D00),
    Genre(id: 35, name: 'Comédia', emoji: '😂', color: 0xFFFFC400),
    Genre(id: 27, name: 'Terror', emoji: '👻', color: 0xFF6A1B9A),
    Genre(id: 10749, name: 'Romance', emoji: '💕', color: 0xFFE91E63),
    Genre(id: 16, name: 'Animação', emoji: '🎨', color: 0xFF00BCD4),
    Genre(id: 878, name: 'Ficção Científica', emoji: '🚀', color: 0xFF1976D2),
    Genre(id: 18, name: 'Drama', emoji: '🎭', color: 0xFF455A64),
    Genre(id: 53, name: 'Suspense', emoji: '🔪', color: 0xFF424242),
    Genre(id: 12, name: 'Aventura', emoji: '🗺️', color: 0xFF388E3C),
    Genre(id: 14, name: 'Fantasia', emoji: '🧙', color: 0xFF7B1FA2),
    Genre(id: 80, name: 'Crime', emoji: '🕵️', color: 0xFF3E2723),
    Genre(id: 9648, name: 'Mistério', emoji: '🔮', color: 0xFF4A148C),
  ];
}
