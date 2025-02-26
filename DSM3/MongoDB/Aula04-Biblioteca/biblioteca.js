// Importa o módulo MongoClient do pacote 'mongodb'
const { MongoClient } = require('mongodb');

// Função principal assíncrona
async function main() {
  // Define a URI de conexão com o MongoDB
  const uri = "mongodb://127.0.0.1:27017";
  // Cria uma nova instância do cliente MongoDB
  const client = new MongoClient(uri);

  try {
    // Conecta ao servidor MongoDB
    await client.connect();
    // Seleciona o banco de dados 'biblioteca'
    const database = client.db('biblioteca');
    // Seleciona a coleção 'livros'
    const livros = database.collection('livros');

    // Inserir documentos na coleção 'livros'
    await livros.insertMany([
      { titulo: "1984", autor: "George Orwell", ano: 1949, genero: "Distopia" },
      { titulo: "Dom Casmurro", autor: "Machado de Assis", ano: 1899, genero: "Romance" },
      { titulo: "O Senhor dos Anéis", autor: "J.R.R. Tolkien", ano: 1954, genero: "Fantasia" }
    ]);

    // Consultar todos os documentos na coleção 'livros'
    const allLivros = await livros.find().toArray();
    console.log('Livros:', allLivros);

    // Atualizar o documento onde o título é "1984"
    await livros.updateOne(
      { titulo: "1984" }, // Filtro para encontrar o documento
      { $set: { ano: 1950 } } // Atualização a ser aplicada
    );

    // Excluir o documento onde o título é "Dom Casmurro"
    await livros.deleteOne({ titulo: "Dom Casmurro" });

    // Consultar todos os documentos na coleção 'livros' após as alterações
    const updatedLivros = await livros.find().toArray();
    console.log('Livros atualizados:', updatedLivros);

  } finally {
    // Fecha a conexão com o servidor MongoDB
    await client.close();
  }
}

// Chama a função principal e captura erros, se houver
main().catch(console.error);