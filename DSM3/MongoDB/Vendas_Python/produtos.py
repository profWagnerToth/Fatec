from db_config import produtos_collection
from bson.objectid import ObjectId

# Criar produto
def cadastrar_produto(nome, preco, quantidade):
    produto = {'nome': nome, 'preco': preco, 'quantidade': quantidade}
    produtos_collection.insert_one(produto)
    print(f'Produto {nome} cadastrado com sucesso!')

# Ler todos os produtos
def listar_produtos():
    produtos = produtos_collection.find()
    print("\n--- Lista de Produtos ---")
    print(f"{'ID':<24} {'Nome':<20} {'Preço':<10} {'Quantidade':<10}")
    print("-" * 60)
    for produto in produtos:
        print(f"{str(produto['_id']):<24} {produto['nome']:<20} {produto['preco']:<10} {produto['quantidade']:<10}")
    print("-" * 60)

# Atualizar produto
def atualizar_produto(produto_id, nome, preco, quantidade):
    produtos_collection.update_one(
        {'_id': ObjectId(produto_id)},
        {'$set': {'nome': nome, 'preco': preco, 'quantidade': quantidade}}
    )
    print(f'Produto {nome} atualizado com sucesso!')

# Deletar produto
def deletar_produto(produto_id):
    produtos_collection.delete_one({'_id': ObjectId(produto_id)})
    print(f'Produto {produto_id} deletado com sucesso!')
