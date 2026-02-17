import 'package:flutter/material.dart';
import 'package:flick_app/widgets/most_popular_slider.dart';
import 'package:flick_app/services/movie_service.dart';
import 'package:flick_app/models/pelicula.dart';
import 'package:flick_app/widgets/nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieService _servicio = MovieService();
  // Mantenemos tus listas y baseUrl originales
  List<Pelicula> _populares = [];
  final String _imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

  @override
  void initState() {
    super.initState();
    _cargarPopulares();
  }

  void _cargarPopulares() async {
    try {
      final populares = await _servicio.obtenerPopulares();
      setState(() => _populares = populares);
    } catch (e) {
      print("Error al cargar populares: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final tx = Theme.of(context).textTheme;
    final clr = Theme.of(context).colorScheme;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment
                    .start, // <-- CORRECCIÓN: Alinea hijos al inicio
                children: [
                  // --- Tu Encabezado Original ---
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
                      const SizedBox(width: 16),
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
                    ],
                  ),
                  const SizedBox(height: 30),
                  // --- Texto Popular (Ahora alineado con el avatar) ---
                  Text(
                    'Most popular this week',
                    style: tx.bodyMedium?.copyWith(
                      color: clr.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // --- Tu Slider ---
          const SizedBox(height: 10),
          _populares.isEmpty
              ? const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              : MostPopularSlider(peliculas: _populares),
        ],
      ),
      // --- Tu Bottom Nav Original ---
      bottomNavigationBar: const NavBar(),
    );
  }
}
