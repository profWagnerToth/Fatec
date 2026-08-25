const mongoose = require('mongoose');

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

// Lista de receitas para inserir
const receitas = [
  {
    nome: 'Bolo de Chocolate',
    ingredientes: ['Farinha', 'Açúcar', 'Ovos', 'Chocolate em pó', 'Fermento'],
    instrucoes: 'Misture todos os ingredientes e asse por 40 minutos.'
  },
  // ... (as outras receitas do arquivo original)
];

// Inserir receitas no banco de dados
async function inserirReceitas() {
  try {
    await Receita.deleteMany({}); // Limpa a coleção antes de inserir
    await Receita.insertMany(receitas);
    console.log('Receitas inseridas com sucesso!');
    mongoose.connection.close();
  } catch (err) {
    console.error('Erro ao inserir receitas:', err);
    mongoose.connection.close();
  }
}

inserirReceitas();