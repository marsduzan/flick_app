import 'package:flutter/material.dart';
import 'package:flick_app/widgets/peliculas_slider.dart';
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
  List<Pelicula> _populares = [];
  List<Pelicula> _upcoming = [];

  @override
  void initState() {
    super.initState();
    _cargarPopulares();
    _cargarUpcoming();
  }

  void _cargarPopulares() async {
    try {
      final populares = await _servicio.obtenerPopulares();
      setState(() => _populares = populares);
    } catch (e) {
      print("Error al cargar populares: $e");
    }
  }

  void _cargarUpcoming() async {
    try {
      final upcoming = await _servicio.obtenerUpcoming();
      setState(() => _upcoming = upcoming);
    } catch (e) {
      print("Error al cargar upcoming: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    final tx = Theme.of(context).textTheme;
    final clr = Theme.of(context).colorScheme;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // --- Header ---
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SafeArea(
                child: Row(
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
                          style: tx.bodySmall?.copyWith(
                            color: clr.primary.withOpacity(0.7),
                          ),
                        ),
                        Text(
                          "Mars Duzan",
                          style: tx.headlineSmall?.copyWith(color: clr.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // --- Sliders ---
            _populares.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PeliculasSlider(
                    titulo: 'Most popular',
                    peliculas: _populares,
                  ),

            const SizedBox(height: 10),

            _upcoming.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : PeliculasSlider(titulo: 'Upcoming', peliculas: _upcoming),

            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
