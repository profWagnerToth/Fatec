/* Verificar dados antes da exclusão */
print("Usuários com nome João Silva antes da exclusão:");
printjson(db.usuarios.find({ nome: "João Silva" }).toArray());

print("Usuários com idade abaixo de 27 antes da exclusão:");
printjson(db.usuarios.find({ idade: { $lt: 27 } }).toArray());

/* Remover um usuário pelo nome */
print("Removendo o usuário João Silva:");
var result1 = db.usuarios.deleteOne({ nome: "João Silva" });
print("Documentos removidos por nome:", result1.deletedCount);

/* Remover todos os usuários com idade abaixo de 27 */
print("Removendo usuários com menos de 27 anos:");
var result2 = db.usuarios.deleteMany({ idade: { $lt: 27 } });
print("Documentos removidos por idade:", result2.deletedCount);

/* Verificar exclusão */
print("Usuários restantes:");
printjson(db.usuarios.find().pretty());

