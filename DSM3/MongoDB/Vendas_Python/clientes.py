from db_config import clientes_collection
from bson.objectid import ObjectId

# Criar cliente
def cadastrar_cliente(nome, email, telefone):
    cliente = {'nome': nome, 'email': email, 'telefone': telefone}
    clientes_collection.insert_one(cliente)
    print(f'Cliente {nome} cadastrado com sucesso!')

# Ler todos os clientes
def listar_clientes():
    clientes = clientes_collection.find()
    print("\n--- Lista de Clientes ---")
    print(f"{'ID':<24} {'Nome':<20} {'E-mail':<30} {'Telefone':<15}")
    print("-" * 80)
    for cliente in clientes:
        print(f"{str(cliente['_id']):<24} {cliente['nome']:<20} {cliente['email']:<30} {cliente['telefone']:<15}")
    print("-" * 80)

# Atualizar cliente
def atualizar_cliente(cliente_id, nome, email, telefone):
    clientes_collection.update_one(
        {'_id': ObjectId(cliente_id)},
        {'$set': {'nome': nome, 'email': email, 'telefone': telefone}}
    )
    print(f'Cliente {nome} atualizado com sucesso!')

# Deletar cliente
def deletar_cliente(cliente_id):
    clientes_collection.delete_one({'_id': ObjectId(cliente_id)})
    print(f'Cliente {cliente_id} deletado com sucesso!')
