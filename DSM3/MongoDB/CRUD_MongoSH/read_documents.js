/* Recuperar todos os usuários */
print("Todos os usuários:");
printjson(db.usuarios.find().toArray());

/* Recuperar um único usuário pelo nome */
print("Recuperando usuário com nome Maria Oliveira:");
printjson(db.usuarios.findOne({ nome: "Maria Oliveira" }));

/* Filtrar usuários acima de 66 anos */
print("Usuários com idade acima de 26:");
printjson(db.usuarios.find({ idade: { $gt: 26 } }).toArray());

