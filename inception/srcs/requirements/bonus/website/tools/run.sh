#!/bin/sh

# Verificar se é a primeira execução (volume vazio)
if [ ! -f "/var/www/website/server.js" ]; then
    echo "📦 Primeira execução - copiando arquivos do website..."
    
    # Copiar arquivos de setup para o volume persistente
    cp -r /tmp/website-setup/* /var/www/website/
    
    echo "📥 Instalando dependências Node.js..."
    cd /var/www/website
    npm install
    
    echo "✅ Website inicializado!"
else
    echo "✅ Website já existe."
fi

# Ir para o diretório do website
cd /var/www/website

echo "✅ Arquivos verificados!"
echo "📦 Dependências já instaladas\n"

# Iniciar o servidor Node.js
node server.js
