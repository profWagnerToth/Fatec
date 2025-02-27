import pandas as pd
from mlxtend.frequent_patterns import apriori, association_rules
import matplotlib.pyplot as plt

# 🔹 Dados de exemplo (Aumentei para mais transações)
data = {
    'ProdutoID': [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 8, 8, 9, 9, 10, 10],
    'Produto': ['Laptop', 'Mouse', 'Laptop', 'Keyboard', 'Mouse', 'Teclado',
                'Monitor', 'Mouse', 'Monitor', 'Teclado', 'Mouse', 'Notebook',
                'Notebook', 'Teclado', 'Teclado', 'Mouse', 'Laptop', 'Mouse', 'Teclado', 'Mouse']
}
df = pd.DataFrame(data)

# 🔹 Criar a matriz de transações
cesta = df.pivot_table(index='ProdutoID', columns='Produto', aggfunc=lambda x: 1, fill_value=0)

# 🔹 Aplicar algoritmo Apriori
frequencia_item = apriori(cesta, min_support=0.05, use_colnames=True)  #Diminuí o suporte

# 🔹 Gerar regras de associação
regras = association_rules(frequencia_item, metric="confidence", min_threshold=0.5)

# 🔹 Exibir regras encontradas
if not regras.empty:
    print(regras[['antecedents', 'consequents', 'support', 'confidence', 'lift']])
    plt.scatter(regras['support'], regras['confidence'])
    plt.xlabel('Suporte')
    plt.ylabel('Confiança')
    plt.title('Regras de Associação')
    plt.show()
else:
    print("Nenhuma regra de associação encontrada. Tente diminuir o min_support ainda mais.")
