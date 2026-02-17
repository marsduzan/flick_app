class Pelicula {
  final int id;
  final String title;
  final String poster;
  final double rating;
  final String sinopsis;

  Pelicula({
    required this.id,
    required this.title,
    required this.poster,
    required this.rating,
    required this.sinopsis,
  });

  factory Pelicula.fromJson(Map<String, dynamic> json) {
    return Pelicula(
      id: json['id'] ?? 0,
      title: json['title'] ?? json['name'] ?? 'No title',
      // Ajustamos según lo que devuelva tu backend (usualmente poster_path)
      poster: json['poster_path'] ?? json['poster'] ?? '',
      rating: (json['vote_average'] as num?)?.toDouble() ?? 0.0,
      sinopsis:
          json['overview'] ?? json['sinopsis'] ?? 'No description available',
    );
  }
}
