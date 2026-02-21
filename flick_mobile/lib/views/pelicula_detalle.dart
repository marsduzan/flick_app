import 'package:flutter/material.dart';
import 'package:flick_app/models/pelicula.dart';

class PeliculaDetalle extends StatelessWidget {
  const PeliculaDetalle({super.key, required this.pelicula});

  final Pelicula pelicula;

  @override
  Widget build(BuildContext context) {
    final tx = Theme.of(context).textTheme;
    final clr = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Poster con difuminado
            Stack(
              children: [
                SizedBox(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(
                    'https://image.tmdb.org/t/p/w500${pelicula.poster}',
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        const Icon(Icons.broken_image, size: 50),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Theme.of(context).scaffoldBackgroundColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Titulo
                  Text(
                    pelicula.title,
                    style: tx.headlineLarge?.copyWith(
                      color: clr.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Rating
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        pelicula.rating.toStringAsFixed(1),
                        style: tx.bodyMedium?.copyWith(color: clr.primary),
                      ),
                      Text(
                        ' / 10',
                        style: tx.bodySmall?.copyWith(
                          color: clr.primary.withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Sinopsis
                  const SizedBox(height: 8),
                  Text(
                    pelicula.sinopsis,
                    style: tx.bodySmall?.copyWith(
                      color: clr.primary.withOpacity(0.8),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
