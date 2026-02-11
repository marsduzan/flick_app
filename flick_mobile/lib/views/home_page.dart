import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flick_app/services/movie_service.dart';
import 'package:flick_app/models/pelicula.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieService _servicio = MovieService();
  final TextEditingController _controlador = TextEditingController();

  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  List<Pelicula> _peliculas = [];
  bool _cargando = false;

  void _buscar() async {
    if (_controlador.text.isEmpty) return;
    FocusScope.of(context).unfocus(); // Esconde el teclado

    setState(() => _cargando = true);
    try {
      final resultados = await _servicio.buscarPeliculas(_controlador.text);
      setState(() {
        _peliculas = resultados;
        _cargando = false;
      });
    } catch (e) {
      setState(() => _cargando = false);
      // Muestra un mensajito (SnackBar) si hay error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tx = Theme.of(context).textTheme;
    final clr = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 40), // Espacio superior
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SafeArea(
              child: Column(
                children: [
                  // Encabezado con avatar y texto bienvenida
                  Row(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 80,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('assets/img/profile.png'),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back!",
                            style: tx.bodyMedium?.copyWith(
                              color: clr.primary.withOpacity(0.7),
                            ),
                          ),
                          Text(
                            "Mars Duzan",
                            style: tx.headlineSmall?.copyWith(
                              color: clr.primary,
                            ),
                          ),
                        ],
                      ),
                      // Carousel de estrenos
                      CarouselSlider(
                        items: _peliculas.map((e) {
                          return Container(
                            width: 200,
                            height: 400,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  "${_imageBaseUrl}${e.poster}",
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                          );
                        }).toList(),

                        options: CarouselOptions(height: 300),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          _cargando
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: _peliculas.length,
                    itemBuilder: (context, index) {
                      final peli = _peliculas[index];
                      return Card(
                        // <-- NUEVO: Envolvemos en una Card para que se vea mejor
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            // <-- Usamos Column principal
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Título grande
                              Text(
                                peli.title,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              // Rating y estrellas
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    "${peli.rating.toStringAsFixed(1)} / 10",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ), // Espacio antes de la imagen
                              // <-- NUEVO: La Imagen
                              ClipRRect(
                                // ClipRRect redondea las esquinas de la imagen
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  // Construimos la URL completa: Base + Path de la peli
                                  '$_imageBaseUrl${peli.poster}',
                                  width: double
                                      .infinity, // Que ocupe todo el ancho
                                  height: 200, // Altura fija
                                  fit: BoxFit
                                      .cover, // La imagen rellena el hueco sin deformarse
                                  // Si no hay imagen o falla la carga, mostramos un icono
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      height: 200,
                                      color: Colors.grey[800],
                                      child: const Center(
                                        child: Icon(
                                          Icons.broken_image,
                                          size: 50,
                                        ),
                                      ),
                                    );
                                  },
                                  // Mientras carga, mostramos un pequeño spinner
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                        if (loadingProgress == null)
                                          return child;
                                        return Container(
                                          height: 200,
                                          child: const Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        );
                                      },
                                ),
                              ),
                              const SizedBox(height: 12),
                              // Sinopsis (opcional, para que veas que cabe más texto debajo)
                              Text(
                                peli.sinopsis,
                                maxLines: 3, // Máximo 3 líneas
                                overflow: TextOverflow
                                    .ellipsis, // Pone "..." si es muy larga
                                style: TextStyle(color: Colors.grey[400]),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
