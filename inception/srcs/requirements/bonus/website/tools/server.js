const express = require('express');
const path = require('path');
const app = express();
const port = 3000;

// Servir arquivos estáticos
app.use(express.static('/var/www/website'));

// Rota principal
app.get('/', (req, res) => {
    res.sendFile(path.join('/var/www/website', 'index.html'));
});

// Rota de saúde para verificar se o serviço está funcionando
app.get('/info', (req, res) => {
    res.json({ 
        status: 'OK',
        serviço: 'Website Node.js',
        timestamp: new Date().toISOString(),
        github_link: 'https://github.com/eliandrosergio/'
    });
});

app.listen(port, '0.0.0.0', () => {
    console.log(`✅ Website Node.js rodando na porta ${port}`);
    console.log(`🌐 Portfolio de Eliandro Faustino - 42 Luanda`);
    console.log(`🔗 Acesso: https://efaustin.42.fr/website/`);
});
