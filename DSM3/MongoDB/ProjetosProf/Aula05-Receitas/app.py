from flask import Flask, render_template, request, redirect, url_for
from pymongo import MongoClient
from bson.objectid import ObjectId

app = Flask(__name__)

# Conectar ao MongoDB
client = MongoClient('mongodb://localhost:27017/')
db = client['receitasDB']
receitas_collection = db['receitas']

@app.route('/')
def index():
    # Obter o termo de busca e a página atual dos parâmetros da URL
    search_query = request.args.get('search')
    page = request.args.get('page', 1, type=int)
    per_page = 5  # Número de receitas por página

    if search_query:
        # Se houver um termo de busca, filtrar as receitas pelo nome
        receitas = receitas_collection.find({'nome': {'$regex': search_query, '$options': 'i'}}).skip((page - 1) * per_page).limit(per_page)
        total = receitas_collection.count_documents({'nome': {'$regex': search_query, '$options': 'i'}})
    else:
        # Caso contrário, obter todas as receitas
        receitas = receitas_collection.find().skip((page - 1) * per_page).limit(per_page)
        total = receitas_collection.count_documents({})

    # Calcular o número total de páginas
    total_pages = (total + per_page - 1) // per_page

    # Renderizar o template 'index.html' com as receitas e informações de paginação
    return render_template('index.html', receitas=receitas, page=page, total_pages=total_pages, search_query=search_query)

@app.route('/adicionar', methods=['POST'])
def adicionar():
    # Obter os dados do formulário
    nome = request.form.get('nome')
    ingredientes = request.form.get('ingredientes').split(',')
    instrucoes = request.form.get('instrucoes')

    # Inserir a nova receita no banco de dados
    receitas_collection.insert_one({'nome': nome, 'ingredientes': [ingrediente.strip() for ingrediente in ingredientes], 'instrucoes': instrucoes})

    # Redirecionar para a página inicial
    return redirect('/')

@app.route('/deletar', methods=['POST'])
def deletar():
    # Obter o ID da receita a ser deletada
    receita_id = request.form.get('id')

    # Remover a receita do banco de dados
    receitas_collection.delete_one({'_id': ObjectId(receita_id)})

    # Redirecionar para a página inicial
    return redirect('/')

@app.route('/editar/<id>', methods=['GET', 'POST'])
def editar(id):
    if request.method == 'POST':
        # Se o método for POST, atualizar a receita no banco de dados
        nome = request.form.get('nome')
        ingredientes = request.form.get('ingredientes').split(',')
        instrucoes = request.form.get('instrucoes')

        # Atualizar a receita com os novos dados
        receitas_collection.update_one({'_id': ObjectId(id)}, {'$set': {'nome': nome, 'ingredientes': [ingrediente.strip() for ingrediente in ingredientes], 'instrucoes': instrucoes}})

        # Redirecionar para a página inicial
        return redirect('/')
    else:
        # Se o método for GET, obter a receita do banco de dados
        receita = receitas_collection.find_one({'_id': ObjectId(id)})

        # Renderizar o template 'editar.html' com os dados da receita
        return render_template('editar.html', receita=receita)

if __name__ == '__main__':
    # Iniciar o servidor Flask
    app.run(debug=True)