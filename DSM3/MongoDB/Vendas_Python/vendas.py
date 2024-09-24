from db_config import produtos_collection, vendas_collection, clientes_collection
from bson.objectid import ObjectId

# Registrar venda
def efetuar_venda(cliente_id, produto_id, quantidade_vendida):
    # Verificar se o cliente existe
    cliente = clientes_collection.find_one({'_id': ObjectId(cliente_id)})
    if not cliente:
        print('Cliente não encontrado!')
        return

    # Verificar se o produto existe
    produto = produtos_collection.find_one({'_id': ObjectId(produto_id)})
    if not produto:
        print('Produto não encontrado!')
        return

    # Verificar se há estoque suficiente
    if produto['quantidade'] < quantidade_vendida:
        print(f'Estoque insuficiente! Quantidade disponível: {produto["quantidade"]}')
        return

    # Atualizar a quantidade no estoque
    nova_quantidade = produto['quantidade'] - quantidade_vendida
    produtos_collection.update_one({'_id': ObjectId(produto_id)}, {'$set': {'quantidade': nova_quantidade}})

    # Registrar a venda
    venda = {'cliente_id': cliente_id, 'produto_id': produto_id, 'quantidade_vendida': quantidade_vendida}
    vendas_collection.insert_one(venda)
    print(f'Venda de {quantidade_vendida} unidade(s) de {produto["nome"]} realizada com sucesso!')

# Listar vendas
def listar_vendas():
    vendas = vendas_collection.find()
    print("\n--- Lista de Vendas ---")
    print(f"{'ID':<24} {'Cliente':<20} {'Produto':<20} {'Quantidade':<10}")
    print("-" * 80)
    for venda in vendas:
        cliente = clientes_collection.find_one({'_id': ObjectId(venda['cliente_id'])})
        produto = produtos_collection.find_one({'_id': ObjectId(venda['produto_id'])})
        print(f"{str(venda['_id']):<24} {cliente['nome']:<20} {produto['nome']:<20} {venda['quantidade_vendida']:<10}")
    print("-" * 80)
