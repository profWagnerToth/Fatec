from pymongo import MongoClient
from bson.objectid import ObjectId

client = MongoClient('mongodb://localhost:27017/')
db = client['sistema_vendas']

produtos_collection = db['produtos']
clientes_collection = db['clientes']
vendas_collection = db['vendas']
