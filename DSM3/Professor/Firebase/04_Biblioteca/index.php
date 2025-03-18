<?php
// Carrega as bibliotecas do Firebase via autoload para permitir o uso da SDK
require_once __DIR__ . '/vendor/autoload.php';
use Kreait\Firebase\Factory;

class FirebaseCrud {
    private $database;

    public function __construct() {
        // Cria uma instância do Firebase usando a Factory
        $firebase = (new Factory)
            ->withServiceAccount(__DIR__ . '/assets/config/chave.json') // Carrega a chave de autenticação JSON
            ->withDatabaseUri('https://biblioteca-dsm3-718ab-default-rtdb.firebaseio.com/') // Define a URL do banco de dados
            ->createDatabase();        

        // Armazena a referência ao banco de dados na propriedade da classe
        $this->database = $firebase;
    }

    // Método para criar um novo registro de livro no Firebase
    public function create($livro) {
        $ref = $this->database->getReference('livros'); // Obtém a referência da coleção "livros"
        $novoLivro = $ref->push($livro); // Insere um novo livro e gera um ID único automaticamente
        return $novoLivro->getKey(); // Retorna o ID gerado para o novo livro
    }

    // Método para obter todos os registros da coleção "livros"
    public function read() {
        $ref = $this->database->getReference('livros'); // Obtém a referência da coleção "livros"
        return $ref->getValue(); // Retorna todos os registros armazenados na coleção
    }

    // Método para atualizar os dados de um livro específico pelo seu ID
    public function update($id, $livro) {
        $this->database->getReference('livros/' . $id)->update($livro); // Atualiza os dados do livro especificado
    }

    // Método para excluir um livro pelo seu ID
    public function delete($id) {
        $this->database->getReference('livros/' . $id)->remove(); // Remove o livro da coleção "livros"
    }

    // Método para listar os livros cadastrados e exibi-los em formato de tabela HTML
    public function listarLivros() {
        $livros = $this->read(); // Obtém a lista de livros cadastrados
        if ($livros) {
            echo '<table class="table table-bordered">';
            echo '<thead class="thead-dark"><tr><th>ID</th><th>Título</th><th>Autor</th><th>Ano</th><th>Gênero</th></tr></thead>';
            echo '<tbody>';
            foreach ($livros as $id => $livro) {
                echo "<tr>
                        <td>{$id}</td>
                        <td>{$livro['titulo']}</td>
                        <td>{$livro['autor']}</td>
                        <td>{$livro['ano']}</td>
                        <td>{$livro['genero']}</td>
                      </tr>";
            }
            echo '</tbody></table>';
        } else {
            echo '<div class="alert alert-warning">Nenhum livro cadastrado.</div>';
        }
    }
}

// Criando uma instância da classe FirebaseCrud para interagir com o banco de dados
$firebaseCrud = new FirebaseCrud();

// Início do HTML para exibição no navegador
echo '<!DOCTYPE html>
<html lang="pt-br">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Teste Firebase CRUD</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-4">';

// Exibe o título da página
echo '<h2 class="text-center text-primary">Testes CRUD no Firebase</h2>';

// Inserir um novo livro e exibir o ID gerado
echo '<h3 class="text-secondary">📌 Inserindo um novo livro:</h3>';
$idLivro = $firebaseCrud->create([
    'titulo' => '1984',
    'autor' => 'George Orwell',
    'ano' => 1949,
    'genero' => 'Distopia'
]);
echo '<div class="alert alert-success">📚 Livro inserido com sucesso! <strong>ID:</strong> ' . $idLivro . '</div>';

// Exibir a lista de livros cadastrados
echo '<h3 class="text-secondary">📋 Livros cadastrados:</h3>';
$firebaseCrud->listarLivros();

// Atualizar um livro e confirmar a atualização
echo '<h3 class="text-secondary">✏️ Atualizando o livro:</h3>';
$firebaseCrud->update($idLivro, [
    'titulo' => '1984 (Edição Revisada)',
    'autor' => 'George Orwell',
    'ano' => 1950,
    'genero' => 'Ficção Científica'
]);
echo '<div class="alert alert-info">✏️ Livro atualizado com sucesso!</div>';
$firebaseCrud->listarLivros();

// Excluir um livro e confirmar a exclusão
echo '<h3 class="text-secondary">🗑️ Excluindo o livro:</h3>';
$firebaseCrud->delete($idLivro);
echo '<div class="alert alert-danger">🗑️ Livro excluído com sucesso!</div>';
$firebaseCrud->listarLivros();

// Finalização do HTML
echo '</body></html>';
?>
