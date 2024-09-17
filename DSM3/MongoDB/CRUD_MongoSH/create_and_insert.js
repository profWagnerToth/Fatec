/* Selecionar ou Criar o banco de dados */
db.gerenciaUsuarios.createDatabase;

/* Criar uma coleção e inserir alguns documentos (Create) */
db.usuarios.insertMany([
    { 
        "nome": "João Silva", 
        "email": "joao@gmail.com", 
        "idade": 30, 
        "profissao": "Engenheiro" 
    },
    { 
        "nome": "Maria Oliveira", 
        "email": "maria@gmail.com", 
        "idade": 25, 
        "profissao": "Designer" 
    },
    { 
        "nome": "Carlos Souza", 
        "email": "carlos@gmail.com", 
        "idade": 28, 
        "profissao": "Desenvolvedor" 
    }
]);

print("Usuários criados com sucesso!");
