const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const { ObjectId } = require('mongodb');
const app = express();

// Configuração do EJS como template engine
app.set('view engine', 'ejs');
app.use(bodyParser.urlencoded({ extended: true }));
app.use(express.static('public'));

// Conexão com o MongoDB
mongoose.connect('mongodb://localhost:27017/receitasDB', {
  useNewUrlParser: true,
  useUnifiedTopology: true
});

// Modelo de Receita
const Receita = mongoose.model('Receita', {
  nome: String,
  ingredientes: [String],
  instrucoes: String
});

// Rotas
app.get('/', async (req, res) => {
  const searchQuery = req.query.search;
  const page = parseInt(req.query.page) || 1;
  const perPage = 5;

  let query = {};
  if (searchQuery) {
    query.nome = { $regex: searchQuery, $options: 'i' };
  }

  try {
    const total = await Receita.countDocuments(query);
    const receitas = await Receita.find(query)
      .skip((page - 1) * perPage)
      .limit(perPage);

    const totalPages = Math.ceil(total / perPage);

    res.render('index', {
      receitas,
      page,
      totalPages,
      searchQuery: searchQuery || ''
    });
  } catch (err) {
    console.error(err);
    res.status(500).send('Erro ao buscar receitas');
  }
});

app.post('/adicionar', async (req, res) => {
  const { nome, ingredientes, instrucoes } = req.body;
  const ingredientesArray = ingredientes.split(',').map(item => item.trim());

  try {
    await Receita.create({
      nome,
      ingredientes: ingredientesArray,
      instrucoes
    });
    res.redirect('/');
  } catch (err) {
    console.error(err);
    res.status(500).send('Erro ao adicionar receita');
  }
});

app.post('/deletar', async (req, res) => {
  try {
    await Receita.deleteOne({ _id: new ObjectId(req.body.id) });
    res.redirect('/');
  } catch (err) {
    console.error(err);
    res.status(500).send('Erro ao deletar receita');
  }
});

app.get('/editar/:id', async (req, res) => {
  try {
    const receita = await Receita.findById(req.params.id);
    res.render('editar', { receita });
  } catch (err) {
    console.error(err);
    res.status(500).send('Erro ao buscar receita');
  }
});

app.post('/editar/:id', async (req, res) => {
  const { nome, ingredientes, instrucoes } = req.body;
  const ingredientesArray = ingredientes.split(',').map(item => item.trim());

  try {
    await Receita.findByIdAndUpdate(req.params.id, {
      nome,
      ingredientes: ingredientesArray,
      instrucoes
    });
    res.redirect('/');
  } catch (err) {
    console.error(err);
    res.status(500).send('Erro ao atualizar receita');
  }
});

// Iniciar servidor
const PORT = 3000;
app.listen(PORT, () => {
  console.log(`Servidor rodando em http://localhost:${PORT}`);
});