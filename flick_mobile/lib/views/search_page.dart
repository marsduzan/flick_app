import 'package:flutter/material.dart';
import 'package:flick_app/services/movie_service.dart';
import 'package:flick_app/models/pelicula.dart';
import 'package:flick_app/widgets/nav_bar.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final MovieService _servicio = MovieService();
  final TextEditingController _controlador = TextEditingController();
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  List<Pelicula> _peliculas = [];
  bool _cargando = false;

  void _buscar() async {
    if (_controlador.text.isEmpty) return;
    FocusScope.of(context).unfocus();
    setState(() => _cargando = true);
    try {
      final resultados = await _servicio.buscarPeliculas(_controlador.text);
      setState(() {
        _peliculas = resultados;
        _cargando = false;
      });
    } catch (e) {
      setState(() => _cargando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // --- TEXTFIELD ARRIBA DEL TODO ---
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                controller: _controlador,
                decoration: InputDecoration(
                  hintText: 'Search movies...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                ),
                onSubmitted: (_) => _buscar(),
              ),
            ),
            // --- RESULTADOS ---
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
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  peli.title,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                const SizedBox(height: 8),
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
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    '$_imageBaseUrl${peli.poster}',
                                    width: double.infinity,
                                    height: 200,
                                    fit: BoxFit.cover,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                              height: 200,
                                              color: Colors.grey[800],
                                              child: const Icon(
                                                Icons.broken_image,
                                              ),
                                            ),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  peli.sinopsis,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
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
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
