import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flick_app/models/pelicula.dart';

class MovieService {
  final String _baseUrl = 'http://10.0.2.2:3000';

  Future<List<Pelicula>> buscarPeliculas(String nombre) async {
    final url = Uri.parse('$_baseUrl/buscar?nombre=$nombre');
    return _fetchList(url);
  }

  // Nuevo método para obtener películas populares
  Future<List<Pelicula>> obtenerPopulares() async {
    final url = Uri.parse('$_baseUrl/populares');
    return _fetchList(url);
  }

  // Nuevo método para obtener películas populares
  Future<List<Pelicula>> obtenerUpcoming() async {
    final url = Uri.parse('$_baseUrl/estrenos');
    return _fetchList(url);
  }

  // Método genérico para evitar repetir código
  Future<List<Pelicula>> _fetchList(Uri url) async {
    try {
      final respuesta = await http.get(url);
      if (respuesta.statusCode == 200) {
        List<dynamic> datosCrudos = json.decode(respuesta.body);
        return datosCrudos.map((item) => Pelicula.fromJson(item)).toList();
      }
      throw Exception('Error: ${respuesta.statusCode}');
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
