//Importar o modulo MongoClient
const {MongoClient} = require('mongodb');

//Função principal
async function main() {
    //Definir a URI de conexão com o MongoDB
    const uri = "mongodb://127.0.0.1:27017";
    //Criar instancia do cliente mongoDB
    const client = new MongoClient(uri);

    try{
        //Conect com o servidor MongoDB
        await client.connect();
        //Seleciona o banco de dados "biblioteca-aula"
        const database = client.db('biblioteca-aula');
        //Seleciona a colecao "livros"
        const livros = database.collection('livros');

        //inserindo dados no banco
        await livros.insertMany([
            {titulo:"1984", autor:"George Orwell", ano: 1949, genero:"Distopia"},
            {titulo:"Dom Casmurro", autor:"Machado de Assis",ano: 1899, genero: "Romance"},
            {titulo: "Senhor dos Aneis", autor: "J.R.R. Tolkei", ano: 1954, genero: "Fantasia"}
        ]);
    }finally{
        await client.close();
    }
}
//Chama a função principal e captura o erro, se houver
main().catch(console.error);