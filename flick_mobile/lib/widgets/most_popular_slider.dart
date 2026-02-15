import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MostPopularSlider extends StatelessWidget {
  final List<String> moviePosters = [
    'https://image.tmdb.org/t/p/w500/poster1.jpg',
    'https://image.tmdb.org/t/p/w500/poster2.jpg',
    'https://image.tmdb.org/t/p/w500/poster3.jpg',
    'https://image.tmdb.org/t/p/w500/poster4.jpg',
    'https://image.tmdb.org/t/p/w500/poster5.jpg',
    'https://image.tmdb.org/t/p/w500/poster6.jpg',
    'https://image.tmdb.org/t/p/w500/poster7.jpg',
    'https://image.tmdb.org/t/p/w500/poster8.jpg',
    'https://image.tmdb.org/t/p/w500/poster9.jpg',
    'https://image.tmdb.org/t/p/w500/poster10.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: moviePosters.length,
      itemBuilder: (context, index, realIndex) {
        return _MovieCard(imageUrl: moviePosters[index]);
      },
      options: CarouselOptions(
        height: 450, // Altura del slider
        enlargeCenterPage: true, // Hace que la imagen central sea más grande
        autoPlay: true, // Se mueve solo
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 0.8, // Cuánto espacio ocupa cada imagen (0.8 = 80%)
      ),
    );
  }
}

class _MovieCard extends StatelessWidget {
  final String imageUrl;
  const _MovieCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover,

        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null)
            return child; // Si ya cargó, muestra la imagen

          return const Center(
            child: CircularProgressIndicator(), // Círculo de carga nativo
          );
        },
        // En caso de que el link de la imagen esté roto
        errorBuilder: (context, error, stackTrace) {
          return const Center(
            child: Icon(Icons.error, color: Colors.red, size: 40),
          );
        },
      ),
    );
  }
}
