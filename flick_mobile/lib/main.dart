import 'package:flutter/material.dart';
import 'services/movie_service.dart';
import 'models/pelicula.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flick Test',
      theme: ThemeData.dark(), // Un toque oscuro queda mejor para cine
      home: const PantallaBusqueda(),
    );
  }
}

class PantallaBusqueda extends StatefulWidget {
  const PantallaBusqueda({super.key});

  @override
  State<PantallaBusqueda> createState() => _PantallaBusquedaState();
}

class _PantallaBusquedaState extends State<PantallaBusqueda> {
  final MovieService _servicio = MovieService();
  final TextEditingController _controlador = TextEditingController();

  // <-- NUEVO: La base URL para las imágenes de TMDB (tamaño w500)
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  List<Pelicula> _peliculas = [];
  bool _cargando = false;

  void _buscar() async {
    if (_controlador.text.isEmpty) return;
    FocusScope.of(context).unfocus(); // Oculta el teclado al buscar

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
    return Scaffold(
      appBar: AppBar(title: const Text('Flick Buscador 🎬')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controlador,
              decoration: InputDecoration(
                labelText: 'Busca una película...',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: _buscar,
                ),
              ),
              onSubmitted: (_) => _buscar(),
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
