#!/bin/bash

echo "🛡️ Iniciando Fail2Ban..."

# Iniciar rsyslog para logs
service rsyslog start

# Aguardar o volume dos logs estar disponível
while [ ! -f /var/log/nginx/access.log ]; do
    echo "⏳ Aguardando logs do nginx..."
    sleep 5
done

# Criar arquivo de log do fail2ban se não existir
touch /var/log/fail2ban/fail2ban.log

# Testar configuração
fail2ban-client --test

if [ $? -ne 0 ]; then
    echo "❌ Erro na configuração do Fail2ban!"
    exit 1
fi

# Iniciar fail2ban em foreground
echo "✅ Fail2Ban configurado e iniciado!"
echo "📊 Para monitorar: fail2ban-client status"

# Mostrar status inicial
fail2ban-client start
sleep 2
fail2ban-client status

# Manter o container rodando e mostrar logs
tail -f /var/log/fail2ban/fail2ban.log &

# Loop para manter container vivo e mostrar estatísticas
while true; do
    sleep 300  # 5 minutos
    echo "📈 Status Fail2Ban $(date):"
    fail2ban-client status nginx-wordpress 2>/dev/null || echo "   Jail nginx-wordpress não ativo ainda"
done
