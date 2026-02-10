class Pelicula {
  Pelicula({
    required this.id,
    required this.title,
    required this.poster,
    required this.sinopsis,
    required this.rating,
    required this.release_date,
  });

  final int id;
  final String title;
  final String poster;
  final String sinopsis;
  final double rating;
  final int release_date;

  factory Pelicula.fromJson(Map<String, dynamic> json) {
    return Pelicula(
      id: json['id'] ?? 0,
      title: json['title'],
      poster: json['poster_path'] ?? '',
      sinopsis: json['overview'],
      rating: (json['vote_average'] as num).toDouble(),
      release_date: json['release_date'] ?? 0,
    );
  }
}
