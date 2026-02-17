import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flick_app/models/pelicula.dart';

class MostPopularSlider extends StatelessWidget {
  final List<Pelicula> peliculas;
  const MostPopularSlider({super.key, required this.peliculas});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: peliculas.length,
      itemBuilder: (context, index, realIndex) {
        final peli = peliculas[index];
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://image.tmdb.org/t/p/w500${peli.poster}',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 50),
          ),
        );
      },
      options: CarouselOptions(
        height: 400,
        enlargeCenterPage: true,
        autoPlay: true,
        viewportFraction: 0.7,
      ),
    );
  }
}
