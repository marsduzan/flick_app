import 'package:flutter/material.dart';
import 'package:flick_app/models/pelicula.dart';
import 'package:flick_app/views/pelicula_detalle.dart';

class PeliculasSlider extends StatelessWidget {
  const PeliculasSlider({
    super.key,
    required this.peliculas,
    required this.titulo,
  });

  final List<Pelicula> peliculas;
  final String titulo;

  @override
  Widget build(BuildContext context) {
    final clr = Theme.of(context).colorScheme;
    final tx = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Título ---
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                titulo,
                style: tx.headlineSmall?.copyWith(
                  color: clr.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: clr.primary,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),

        // --- Slider ---
        SizedBox(
          height: 280,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: peliculas.length,
            itemBuilder: (context, index) {
              final pelicula = peliculas[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PeliculaDetalle(pelicula: pelicula),
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
                            'https://image.tmdb.org/t/p/w500${pelicula.poster}',
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 50),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        pelicula.title,
                        style: tx.bodySmall?.copyWith(
                          color: clr.primary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.star, color: clr.onPrimary, size: 16),
                          const SizedBox(width: 4),
                          Text(
                            '${pelicula.rating.toStringAsFixed(1)} / 10',
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
        ),
      ],
    );
  }
}
