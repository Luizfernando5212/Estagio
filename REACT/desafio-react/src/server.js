const express = require('express');
const fetch = require('node-fetch');

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/filmes', async (req, res) => {
  const response = await fetch('http://localhost:8080/treinamento-jpa-lfoliveira/webapi/filmes');
  const data = await response.json();
  res.send(data);
});

const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
