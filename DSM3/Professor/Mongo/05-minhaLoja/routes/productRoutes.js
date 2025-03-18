const express = require('express');
const Product = require('../models/Product');
const router = express.Router();

// Criar um produto
router.post('/products', async (req, res) => {
    const product = new Product(req.body);
    await product.save();
    res.status(201).send(product);
});

// Listar todos os produtos
router.get('/products', async (req, res) => {
    const products = await Product.find();
    res.send(products);
});

// Obter um produto por ID
router.get('/products/:id', async (req, res) => {
    const product = await Product.findById(req.params.id);
    if (!product) return res.status(404).send('Produto não encontrado');
    res.send(product);
});

// Atualizar um produto
router.put('/products/:id', async (req, res) => {
    const product = await Product.findByIdAndUpdate(req.params.id, req.body, { new: true });
    if (!product) return res.status(404).send('Produto não encontrado');
    res.send(product);
});

// Excluir um produto
router.delete('/products/:id', async (req, res) => {
    const product = await Product.findByIdAndDelete(req.params.id);
    if (!product) return res.status(404).send('Produto não encontrado');
    res.send(product);
});

module.exports = router;