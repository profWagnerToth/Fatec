from pymongo import MongoClient

# Conecte-se ao MongoDB
client = MongoClient('mongodb://localhost:27017/')
db = client['receitasDB']
receitas_collection = db['receitas']

# Lista de receitas para inserir
receitas = [
    {
        'nome': 'Bolo de Chocolate',
        'ingredientes': ['Farinha', 'Açúcar', 'Ovos', 'Chocolate em pó', 'Fermento'],
        'instrucoes': 'Misture todos os ingredientes e asse por 40 minutos.'
    },
    {
        'nome': 'Salada de Frutas',
        'ingredientes': ['Maçã', 'Banana', 'Laranja', 'Uva', 'Manga'],
        'instrucoes': 'Corte todas as frutas e misture em uma tigela.'
    },
    {
        'nome': 'Sopa de Legumes',
        'ingredientes': ['Cenoura', 'Batata', 'Abobrinha', 'Cebola', 'Alho'],
        'instrucoes': 'Cozinhe todos os legumes em água até ficarem macios.'
    },
    {
        'nome': 'Macarrão à Bolonhesa',
        'ingredientes': ['Macarrão', 'Carne moída', 'Molho de tomate', 'Cebola', 'Alho'],
        'instrucoes': 'Cozinhe o macarrão e prepare o molho com a carne moída.'
    },
    {
        'nome': 'Panqueca',
        'ingredientes': ['Farinha', 'Leite', 'Ovos', 'Sal', 'Óleo'],
        'instrucoes': 'Misture todos os ingredientes e frite em uma frigideira.'
    },
    {
        'nome': 'Omelete',
        'ingredientes': ['Ovos', 'Queijo', 'Presunto', 'Sal', 'Pimenta'],
        'instrucoes': 'Bata os ovos e adicione os outros ingredientes. Cozinhe em uma frigideira.'
    },
    {
        'nome': 'Arroz com Feijão',
        'ingredientes': ['Arroz', 'Feijão', 'Cebola', 'Alho', 'Sal'],
        'instrucoes': 'Cozinhe o arroz e o feijão separadamente e depois misture.'
    },
    {
        'nome': 'Torta de Maçã',
        'ingredientes': ['Farinha', 'Açúcar', 'Maçãs', 'Canela', 'Manteiga'],
        'instrucoes': 'Prepare a massa e recheie com as maçãs. Asse por 45 minutos.'
    },
    {
        'nome': 'Pizza Margherita',
        'ingredientes': ['Massa de pizza', 'Molho de tomate', 'Queijo mussarela', 'Manjericão'],
        'instrucoes': 'Monte a pizza e asse até o queijo derreter.'
    },
    {
        'nome': 'Brigadeiro',
        'ingredientes': ['Leite condensado', 'Chocolate em pó', 'Manteiga', 'Granulado'],
        'instrucoes': 'Cozinhe o leite condensado com o chocolate e a manteiga até desgrudar da panela. Faça bolinhas e passe no granulado.'
    }
]

# Inserir receitas no banco de dados
receitas_collection.insert_many(receitas)
print("Receitas inseridas com sucesso!")