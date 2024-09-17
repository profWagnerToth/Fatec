const { MongoClient } = require('mongodb');
const readline = require('readline-sync');

// URL de conexão com o MongoDB
const url = 'mongodb://localhost:27017';
const dbName = 'gerenciaUsuarios';

async function main() {
  const client = new MongoClient(url, { useNewUrlParser: true, useUnifiedTopology: true });
  await client.connect();
  console.log('Conectado ao banco de dados');

  const db = client.db(dbName);
  const usuarios = db.collection('usuarios');

  while (true) {
    console.log('Escolha uma opção:');
    console.log('1. Criar Usuário');
    console.log('2. Ler Usuários');
    console.log('3. Atualizar Usuário');
    console.log('4. Excluir Usuário');
    console.log('5. Sair');

    const escolha = readline.question('Digite o número da opção: ');

    switch (escolha) {
      case '1':
        await criarUsuario(usuarios);
        break;
      case '2':
        await lerUsuarios(usuarios);
        break;
      case '3':
        await atualizarUsuario(usuarios);
        break;
      case '4':
        await excluirUsuario(usuarios);
        break;
      case '5':
        await client.close();
        console.log('Desconectado do banco de dados');
        process.exit();
      default:
        console.log('Opção inválida. Tente novamente.');
    }
  }
}

async function criarUsuario(collection) {
  const nome = readline.question('Nome: ');
  const idade = parseInt(readline.question('Idade: '), 10);
  const email = readline.question('Email: ');

  const resultado = await collection.insertOne({ nome, idade, email });
  console.log('Usuário criado com o ID:', resultado.insertedId);
}

async function lerUsuarios(collection) {
  const usuarios = await collection.find().toArray();
  console.log('Usuários encontrados:');
  console.log(usuarios);
}

async function atualizarUsuario(collection) {
    try {
      const nome = readline.question('Nome do usuário a ser atualizado: ');
      const novoEmail = readline.question('Novo email: ');
  
      // Verifica se o usuário existe antes de tentar atualizar
      const usuario = await collection.findOne({ nome });
      if (!usuario) {
        console.log('Usuário não encontrado.');
        return;
      }
  
      // Atualiza o usuário com o novo email
      const resultado = await collection.updateOne(
        { nome },
        { $set: { email: novoEmail } }
      );
  
      if (resultado.modifiedCount === 0) {
        console.log('Nenhuma atualização realizada. Verifique se os dados estão corretos.');
      } else {
        console.log('Usuário atualizado com sucesso.');
      }
    } catch (error) {
      console.error('Erro ao atualizar o usuário:', error);
    }
  }
  

async function excluirUsuario(collection) {
  const nome = readline.question('Nome do usuário a ser excluído: ');

  const resultado = await collection.deleteOne({ nome });
  console.log('Documentos excluídos:', resultado.deletedCount);
}

main().catch(console.error);
