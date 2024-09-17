/* Atualizar o email de um usuário */
print("Atualizando o email de Carlos Souza:");
db.usuarios.updateOne(
    { nome: "Carlos Souza" },  // Critério de busca
    { $set: { email: "carlos_souza@gmail.com" } }  // O que será atualizado
);

/* Adicionar um campo novo (endereço) para Maria Oliveira */
print("Adicionando endereço para Maria Oliveira:");
db.usuarios.updateOne(
    { nome: "Maria Oliveira" },
    { $set: { endereco: "Rua ABC, 123, Registro, SP" } }
);

/* Verificar atualização */
print("Verificando atualizações para Carlos Souza:");
printjson(db.usuarios.findOne({ nome: "Carlos Souza" }));

print("Verificando atualizações para Maria Oliveira:");
printjson(db.usuarios.findOne({ nome: "Maria Oliveira" }));

