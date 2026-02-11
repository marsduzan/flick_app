import 'package:flick_app/views/home_page.dart';
import 'package:flutter/material.dart';
import 'services/movie_service.dart';
import 'models/pelicula.dart';
import 'package:google_fonts/google_fonts.dart';

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
            fontSize: 20,
          ),
          bodyMedium: TextStyle(
            fontFamily: GoogleFonts.montserrat().fontFamily,
            fontSize: 14,
          ),
        ),
      ),

      home: const HomePage(),
    );
  }
}
