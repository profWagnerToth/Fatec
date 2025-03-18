const express = require('express');
const mongoose = require('mongoose');
const path = require('path');
const app = express();
const port = 3000;

mongoose.connect('mongodb://localhost/minhaLoja', { useNewUrlParser: true, useUnifiedTopology: true });

app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

const productRoutes = require('./routes/productRoutes');
app.use('/api', productRoutes);

app.listen(port, () => {
    console.log(`Servidor rodando em http://localhost:${port}`);
});