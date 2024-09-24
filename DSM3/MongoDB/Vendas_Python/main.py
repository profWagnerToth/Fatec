from produtos import cadastrar_produto, listar_produtos, atualizar_produto, deletar_produto
from clientes import cadastrar_cliente, listar_clientes, atualizar_cliente, deletar_cliente
from vendas import efetuar_venda, listar_vendas

def menu():
    while True:
        print("\n--- Sistema de Vendas ---")
        print("1. Cadastrar Produto")
        print("2. Listar Produtos")
        print("3. Atualizar Produto")
        print("4. Deletar Produto")
        print("5. Cadastrar Cliente")
        print("6. Listar Clientes")
        print("7. Atualizar Cliente")
        print("8. Deletar Cliente")
        print("9. Efetuar Venda")
        print("10. Listar Vendas")
        print("11. Sair")
        opcao = input("Escolha uma opção: ")

        if opcao == '1':
            nome = input('Nome do produto: ')
            preco = float(input('Preço: '))
            quantidade = int(input('Quantidade: '))
            cadastrar_produto(nome, preco, quantidade)

        elif opcao == '2':
            listar_produtos()

        elif opcao == '3':
            produto_id = input('ID do produto: ')
            nome = input('Nome do produto: ')
            preco = float(input('Preço: '))
            quantidade = int(input('Quantidade: '))
            atualizar_produto(produto_id, nome, preco, quantidade)

        elif opcao == '4':
            produto_id = input('ID do produto: ')
            deletar_produto(produto_id)

        elif opcao == '5':
            nome = input('Nome do cliente: ')
            email = input('E-mail: ')
            telefone = input('Telefone: ')
            cadastrar_cliente(nome, email, telefone)

        elif opcao == '6':
            listar_clientes()

        elif opcao == '7':
            cliente_id = input('ID do cliente: ')
            nome = input('Nome do cliente: ')
            email = input('E-mail: ')
            telefone = input('Telefone: ')
            atualizar_cliente(cliente_id, nome, email, telefone)

        elif opcao == '8':
            cliente_id = input('ID do cliente: ')
            deletar_cliente(cliente_id)

        elif opcao == '9':
            cliente_id = input('ID do cliente: ')
            produto_id = input('ID do produto: ')
            quantidade_vendida = int(input('Quantidade vendida: '))
            efetuar_venda(cliente_id, produto_id, quantidade_vendida)

        elif opcao == '10':
            listar_vendas()

        elif opcao == '11':
            break

        else:
            print("Opção inválida!")

menu()
