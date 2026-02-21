import 'package:flutter/material.dart';
import 'package:flick_app/models/pelicula.dart';
import 'package:flick_app/views/pelicula_detalle.dart';

class MostPopularSlider extends StatelessWidget {
  const MostPopularSlider({super.key, required this.peliculas});

  final List<Pelicula> peliculas;

  @override
  Widget build(BuildContext context) {
    final clr = Theme.of(context).colorScheme;
    final tx = Theme.of(context).textTheme;

    // --- Tu Slider Original ---
    return SizedBox(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: peliculas.length,
        itemBuilder: (context, index) {
          // Definimos a cada pelicula de la lista
          final peli = peliculas[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PeliculaDetalle(pelicula: peli),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.only(
                left: index == 0 ? 20 : 10,
                right: index == peliculas.length - 1 ? 20 : 0,
              ),
              width: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: SizedBox(
                      height: 220,
                      child: Image.network(
                        'https://image.tmdb.org/t/p/w500${peli.poster}',
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) =>
                            const Icon(Icons.broken_image, size: 50),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    peli.title,
                    style: tx.bodySmall?.copyWith(
                      color: clr.primary,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(Icons.star, color: clr.onPrimary, size: 16),
                      SizedBox(width: 4),
                      Text(
                        '${peli.rating.toStringAsFixed(1)} / 10',
                        style: tx.bodySmall?.copyWith(
                          color: clr.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
