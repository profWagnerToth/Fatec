from pymongo import MongoClient

def conectar():
    try:
        conexao = MongoClient('localhost', 27017)
        print("Conexão com o MongoDB estabelecida com sucesso!")
        return conexao
    except Exception as e:
        print(f"Erro ao conectar ao MongoDB: {e}")


from pymongo import MongoClient  # Biblioteca para conectar o Python ao MongoDB
from pymongo import errors  # Lidar com erros do MongoDB
from bson import ObjectId  # Manipular identificadores únicos no MongoDB
from bson import errors as berros  # Para capturar erros específicos relacionados ao BSON

def conectar():
    # Função para conectar ao servidor MongoDB
    conexao = MongoClient('localhost', 27017)  # Conectar ao servidor MongoDB
    return conexao  # Retorna a conexão

def desconectar(conexao):
    # Função para desconectar do servidor MongoDB
    if conexao:
        conexao.close()  # Fecha a conexão com o MongoDB

def listar():
    # Função para listar todos os produtos
    conexao = conectar()  # Cria a conexão com o MongoDB
    db = conexao.python_mongo  # Nome do banco de dados MongoDB

    try:
        # Verifica se há produtos cadastrados
        if db.produtos.count_documents({}) > 0:
            produtos = db.produtos.find()  # Obtém todos os produtos
            print('Listando Produtos')
            print('-----------------')
            for produto in produtos:
                print(f"ID: {produto['_id']}")  # Exibe o ID do produto
                print(f"Produto: {produto['nome']}")  # Exibe o nome do produto
                print(f"Preço: {produto['preco']}")  # Exibe o preço
                print(f"Estoque: {produto['estoque']}")  # Exibe o estoque
                print('------------------------------')
        else:
            print('Não existem produtos cadastrados.')
    except errors.PyMongoError as e:
        print(f'Erro ao acessar o banco de dados: {e}')  # Captura erro geral de MongoDB
    finally:
        desconectar(conexao)  # Desconecta do banco

def inserir():
    # Função para inserir um novo produto
    conexao = conectar()
    db = conexao.python_mongo
    nome = input('Informe o nome do produto: ')
    preco = float(input('Informe o preço do produto: '))
    estoque = int(input('Informe o estoque do produto: '))

    try:
        db.produtos.insert_one({  # Insere os dados do produto no banco
            "nome": nome,
            "preco": preco,
            "estoque": estoque
        })
        print(f'O Produto {nome} foi inserido com sucesso')
    except errors.PyMongoError as e:
        print(f'Não foi possível inserir o produto. {e}')
    finally:
        desconectar(conexao)

def atualizar():
    # Função para atualizar um produto existente
    conexao = conectar()
    db = conexao.python_mongo

    _id = input('Informe o ID do produto: ')
    nome = input('Informe o nome do produto: ')
    preco = float(input('Informe o preço do produto: '))
    estoque = int(input('Informe o estoque do produto: '))

    try:
        # Verifica se há produtos no banco
        if db.produtos.count_documents({}) > 0:
            res = db.produtos.update_one(
                {"_id": ObjectId(_id)},  # Localiza o produto pelo ID
                {"$set": {  # Atualiza os campos especificados
                    "nome": nome,
                    "preco": preco,
                    "estoque": estoque
                }}
            )
            if res.modified_count == 1:
                print(f'O produto {nome} foi atualizado com sucesso!')
            else:
                print('Não foi possível atualizar o produto.')
        else:
            print('Não existem produtos a serem atualizados.')
    except errors.PyMongoError as e:
        print(f'Erro ao acessar o banco de dados: {e}')
    except berros.InvalidId as f:  # Captura erro de ObjectId inválido
        print(f'ObjectId inválido. {f}')
    finally:
        desconectar(conexao)

def deletar():
    # Função para deletar um produto
    conexao = conectar()
    db = conexao.python_mongo

    _id = input('Informe o ID do produto: ')

    try:
        # Verifica se há produtos cadastrados
        if db.produtos.count_documents({}) > 0:
            res = db.produtos.delete_one({"_id": ObjectId(_id)})  # Deleta o produto pelo ID
            if res.deleted_count > 0:
                print('Produto excluído com sucesso!')
            else:
                print('Não foi possível excluir o produto.')
        else:
            print('Não existem produtos a serem excluídos.')
    except errors.PyMongoError as e:
        print(f'Erro ao acessar o banco de dados: {e}')
    except berros.InvalidId as f:
        print(f'ObjectId inválido. {f}')
    finally:
        desconectar(conexao)

def menu():
    # Função que exibe o menu principal
    print('============ Gerenciador de Produtos ======================')
    print('Selecione a Opção desejada:')
    print('1 - Listar Produtos')
    print('2 - Inserir Produtos')
    print('3 - Atualizar Produtos')
    print('4 - Deletar Produtos')
    opcao = int(input())
    if opcao in [1, 2, 3, 4]:
        if opcao == 1:
            listar()
        elif opcao == 2:
            inserir()
        elif opcao == 3:
            atualizar()
        elif opcao == 4:
            deletar()
    else:
        print('Opção Inválida.')