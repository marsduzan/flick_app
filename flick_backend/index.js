
require('dotenv').config();
const express = require('express');
const axios = require('axios');
const app = express();
const port = process.env.PORT || 3000;

app.get('/', (req, res) => {
  res.send('¡Servidor de Flick funcionando! 🍿');
});

app.get('/buscar', async (req, res) => {
  const pelic = req.query.nombre;

  try {
    const respuesta = await axios.get(`https://api.themoviedb.org/3/search/movie?query=${pelic}`, {
      headers: {
        Authorization: `Bearer ${process.env.TMDB_TOKEN}`
      }
    });

    res.json(respuesta.data.results);
  } catch (error) {
    console.log(error);
    res.status(500).json({mensaje: 'Error al conectar con la API de cine'})
  }
});

app.listen(port, () => {
  console.log(`Flick en marcha en http://localhost:${port}`);
});