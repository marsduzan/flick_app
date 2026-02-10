import 'dart:convert';
import 'package:http/http.dart' as http; // Paquete para hacer solicitudes HTTP
import 'package:flick_app/models/pelicula.dart';

class MovieService {
  // URL base de nuestro backend, que se encargará de comunicarse con la API de cine
  final String _baseUrl = 'http://localhost:3000';

  // Método para buscar películas por nombre, hace una solicitud GET a nuestro backend y devuelve una lista de objetos Pelicula
  Future<List<Pelicula>> buscarPeliculas(String nombre) async {
    final url = Uri.parse('$_baseUrl/buscar?nombre=$nombre');

    try {
      final respuesta = await http.get(url);

      if (respuesta.statusCode == 200) {
        List<dynamic> datosCrudos = json.decode(respuesta.body);

        return datosCrudos.map((item) => Pelicula.fromJson(item)).toList();
      } else {
        throw Exception('Error en el servidor: ${respuesta.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
