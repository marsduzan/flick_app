
require('dotenv').config();
const express = require('express'); // Framework para crear el servidor
const axios = require('axios'); // Cliente HTTP para hacer solicitudes a la API de cine
const app = express(); // Crear una instancia de Express
const port = process.env.PORT || 3000; // Importar nuestro port de .env o usar 3000 por defecto

// Obtenemos respuesta desde la ruta raíz para verificar que el servidor está funcionando
app.get('/', (req, res) => {
  res.send('¡Servidor de Flick funcionando! 🍿');
});

// Ruta para buscar películas por nombre, recibe el nombre como query parameter
app.get('/buscar', async (req, res) => {
  const pelic = req.query.nombre;

  // Validamos que se haya proporcionado un nombre de película
  try {
    const respuesta = await axios.get(`https://api.themoviedb.org/3/search/movie?query=${pelic}`, {
      headers: {
        Authorization: `Bearer ${process.env.TMDB_TOKEN}`
      }
    });

    // Enviamos solo los resultados de la búsqueda al cliente
    res.json(respuesta.data.results);
  } catch (error) {
    console.log(error);
    res.status(500).json({mensaje: 'Error al conectar con la API de cine'})
  }
});

// Iniciamos el servidor en el puerto especificado
app.listen(port, () => {
  console.log(`Flick en marcha en http://localhost:${port}`);
});

app.get('/populares', async (req, res) => {
  try {
    const respuesta = await axios.get('https://api.themoviedb.org/3/trending/movie/week', {
      headers: {
        Authorization: `Bearer ${process.env.TMDB_TOKEN}`
      }
    });

    res.json(respuesta.data.results);
  } catch (error) {
    console.log(error);
    res.status(500).json({ mensaje: 'Error al conectar con la API de cine' });
  }
});