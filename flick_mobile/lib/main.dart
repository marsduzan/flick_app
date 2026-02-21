import 'package:flick_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'services/movie_service.dart';
import 'models/pelicula.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flick_app/views/home_page.dart';
import 'package:flick_app/views/search_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flick: Buscador de Películas',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF1b2328),
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF121214),
          primary: Color(0xFFffffff),
          onPrimary: Color(0xFFfada5e),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
            ).fontFamily,
            fontSize: 30,
          ),
          headlineSmall: TextStyle(
            fontFamily: GoogleFonts.montserrat(
              fontWeight: FontWeight.bold,
            ).fontFamily,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 18,
          ),
          bodySmall: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 12,
          ),
        ),
      ),

      initialRoute: '/', // La ruta que se carga al abrir la app
      routes: {
        // El contenedor con la navegación inferior
        '/home': (context) => const HomePage(), // Pestaña de inicio (populares)
        '/search': (context) => const SearchPage(),
      },
      // Pestaña de búsqueda
      home: const HomePage(),
    );
  }
}
