document.getElementById('productForm').addEventListener('submit', async function(event) {
    event.preventDefault();
    const name = document.getElementById('name').value;
    const price = document.getElementById('price').value;
    const description = document.getElementById('description').value;

    const response = await fetch('/api/products', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({ name, price, description })
    });

    if (response.ok) {
        alert('Produto adicionado com sucesso!');
        loadProducts();

        // Limpar os campos do formulário
        document.getElementById('name').value = '';
        document.getElementById('price').value = '';
        document.getElementById('description').value = '';
    } else {
        alert('Erro ao adicionar produto');
    }
});

async function loadProducts() {
    const response = await fetch('/api/products');
    const products = await response.json();
    const productList = document.getElementById('productList');
    productList.innerHTML = '';

    products.forEach(product => {
        const li = document.createElement('li');
        li.textContent = `${product.name} - R$ ${product.price} - ${product.description}`;
        
        const editButton = document.createElement('button');
        editButton.textContent = 'Editar';
        editButton.addEventListener('click', () => editProduct(product._id));
        
        const deleteButton = document.createElement('button');
        deleteButton.textContent = 'Excluir';
        deleteButton.addEventListener('click', () => deleteProduct(product._id));
        
        li.appendChild(editButton);
        li.appendChild(deleteButton);
        productList.appendChild(li);
    });
}

async function editProduct(id) {
    const newName = prompt('Novo nome do produto:');
    const newPrice = prompt('Novo preço do produto:');
    const newDescription = prompt('Nova descrição do produto:');

    if (newName && newPrice && newDescription) {
        const response = await fetch(`/api/products/${id}`, {
            method: 'PUT',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ name: newName, price: newPrice, description: newDescription })
        });

        if (response.ok) {
            alert('Produto atualizado com sucesso!');
            loadProducts();
        } else {
            alert('Erro ao atualizar produto');
        }
    }
}

async function deleteProduct(id) {
    const confirmDelete = confirm('Tem certeza que deseja excluir este produto?');
    if (confirmDelete) {
        const response = await fetch(`/api/products/${id}`, {
            method: 'DELETE'
        });

        if (response.ok) {
            alert('Produto excluído com sucesso!');
            loadProducts();
        } else {
            alert('Erro ao excluir produto');
        }
    }
}

document.addEventListener('DOMContentLoaded', loadProducts);