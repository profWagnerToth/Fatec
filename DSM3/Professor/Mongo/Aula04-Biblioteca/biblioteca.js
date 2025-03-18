// Importa o módulo MongoClient do pacote 'mongodb'
const { MongoClient } = require('mongodb');
require('dotenv').config(); // Para gerenciar variáveis de ambiente

// Função para conectar ao MongoDB
async function connectToMongoDB() {
  const uri = process.env.MONGODB_URI || "mongodb://127.0.0.1:27017";
  const client = new MongoClient(uri);
  await client.connect();
  console.log('Conectado ao MongoDB');
  return client;
}

// Função para inserir documentos na coleção 'livros'
async function insertLivros(livrosCollection) {
  const documentosInseridos = await livrosCollection.insertMany([
    { titulo: "1984", autor: "George Orwell", ano: 1949, genero: "Distopia" },
    { titulo: "Dom Casmurro", autor: "Machado de Assis", ano: 1899, genero: "Romance" },
    { titulo: "O Senhor dos Anéis", autor: "J.R.R. Tolkien", ano: 1954, genero: "Fantasia" }
  ]);
  console.log(`${documentosInseridos.insertedCount} documentos inseridos`);
}

// Função para consultar todos os documentos na coleção 'livros'
async function findAllLivros(livrosCollection) {
  const allLivros = await livrosCollection.find().toArray();
  console.log('Livros:', allLivros);
}

// Função para atualizar um documento na coleção 'livros'
async function updateLivro(livrosCollection) {
  const resultadoAtualizacao = await livrosCollection.updateOne(
    { titulo: "1984" }, // Filtro para encontrar o documento
    { $set: { ano: 1950 } } // Atualização a ser aplicada
  );
  console.log(`${resultadoAtualizacao.modifiedCount} documento(s) atualizado(s)`);
}

// Função para excluir um documento na coleção 'livros'
async function deleteLivro(livrosCollection) {
  const resultadoExclusao = await livrosCollection.deleteOne({ titulo: "Dom Casmurro" });
  console.log(`${resultadoExclusao.deletedCount} documento(s) excluído(s)`);
}

// Função principal assíncrona
async function main() {
  let client;

  try {
    // Conecta ao MongoDB
    client = await connectToMongoDB();

    // Seleciona o banco de dados 'biblioteca' e a coleção 'livros'
    const database = client.db('biblioteca');
    const livrosCollection = database.collection('livros');

    // Inserir documentos na coleção 'livros'
    await insertLivros(livrosCollection);

    // Consultar todos os documentos na coleção 'livros'
    await findAllLivros(livrosCollection);

    // Atualizar o documento onde o título é "1984"
    await updateLivro(livrosCollection);

    // Excluir o documento onde o título é "Dom Casmurro"
    await deleteLivro(livrosCollection);

    // Consultar todos os documentos na coleção 'livros' após as alterações
    await findAllLivros(livrosCollection);

  } catch (error) {
    console.error('Erro durante a execução:', error);
  } finally {
    // Fecha a conexão com o servidor MongoDB
    if (client) {
      await client.close();
      console.log('Conexão com o MongoDB fechada');
    }
  }
}

// Chama a função principal
main().catch(console.error);