# 42-inception | 🚀 Inception - Projeto 42

> **Virtualização de serviços com Docker: Uma infraestrutura completa em containers**

## 📋 Sobre o Projeto

O **Inception** é um projeto da escola 42 que visa aprofundar conhecimentos em administração de sistemas através da tecnologia Docker. O desafio consiste em criar uma infraestrutura completa virtualizada usando containers Docker, implementando as melhores práticas de segurança e arquitetura.

### 🎯 Objetivo Principal
Construir uma aplicação web completa usando **apenas containers Docker customizados**, sem usar imagens pré-construídas do DockerHub (exceto Alpine/Debian base).

## 🏗️ Arquitetura do Sistema

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│     NGINX       │    │   WORDPRESS     │    │    MARIADB      │
│   (Proxy SSL)   │◄──►│   (PHP-FPM)     │◄──►│   (Database)    │
│   Port: 443     │    │   Port: 9000    │    │   Port: 3306    │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         └───────────────────────┼───────────────────────┘
                                 │
                    ┌─────────────────┐
                    │   Docker Network│
                    │   (inception)   │
                    └─────────────────┘
```

## 🔧 Componentes Implementados

### 🌐 **NGINX Container**
- **Base**: Debian Bullseye Slim
- **Função**: Proxy reverso e terminação SSL
- **Características**:
  - Suporte **exclusivo** a TLS 1.2/1.3
  - Certificados SSL auto-assinados
  - Redirecionamento HTTP → HTTPS
  - Headers de segurança implementados
  - Configuração otimizada para PHP-FPM

### 🌍 **WordPress Container**
- **Base**: Debian Bullseye Slim
- **Função**: CMS e aplicação web
- **Características**:
  - PHP 7.4 com FPM
  - WordPress CLI (wp-cli) para automação
  - Configuração automática na inicialização
  - Tema personalizado (Teluro)
  - **Dois usuários**: Admin + Author

### 🗄️ **MariaDB Container**
- **Base**: Debian Bullseye Slim
- **Função**: Sistema de gerenciamento de banco de dados
- **Características**:
  - Configuração automática do banco
  - Usuário dedicado para WordPress
  - Persistência de dados via volumes
  - Configuração de segurança implementada

### 🛢️ **Adminer Container**
- **Base**: Alpine
- **Função**: Interface web para gerenciamento do MariaDB
- **Características**:
  - Interface leve e intuitiva
  - Conexão direta com o banco MariaDB
  - Roda sob proxy do NGINX em HTTPS
  - Útil para debugging e acesso manual ao banco

### 🎮 **Game Website Container**
- **Base**: Debian Bullseye Slim
- **Função**: Hospedagem de um jogo de tiro ao alvo em HTML/CSS/JS com Node.js
- **Características**:
  - Servidor Node.js leve (porta interna 4444)
  - Conteúdo estático e responsivo
  - Acesso via proxy seguro (NGINX)
  - Volume dedicado para arquivos do jogo

## 📂 Estrutura do Projeto

```
inception/
├── Makefile                          # Automação do projeto
├── srcs/
│   ├── docker-compose.yml            # Orquestração dos containers
│   ├── .env                          # Variáveis de ambiente
│   └── requirements/
│       ├── nginx/
│       │   ├── Dockerfile
│       │   ├── conf/
│       │   │   ├── nginx.conf
│       │   │   └── default.conf
│       │   └── tools/
│       │       └── run.sh
│       ├── wordpress/
│       │   ├── Dockerfile
│       │   ├── conf/
│       │   │   └── www.conf
│       │   └── tools/
│       │       └── run.sh
│       ├── mariadb/
│       │    ├── Dockerfile
│       │    ├── conf/
│       │    │   ├── my.cnf
│       │    │   └── init.sql
│       │    └── tools/
│       │        └── run.sh
│       └── bonus/
│           ├── adminer
│           │   ├── Dockerfile/
│           │   └── tools/
│           │       └── script.sh
│           └── website
│               ├── Dockerfile/
│               └── tools/
│                   ├── server.js
│                   └── public/       # Arquivos do jogo
└── data/                             # Volumes persistentes
    ├── mariadb/
    └── wordpress/
```

## 🛠️ Tecnologias e Conceitos Aplicados

### 🐳 **Docker & Container Technology**
- **Dockerfiles customizados** para cada serviço
- **Multi-stage builds** para otimização
- **Container networking** com bridge driver
- **Volume management** para persistência
- **Security best practices** implementadas

### 🔒 **Segurança**
- **SSL/TLS exclusivo** (1.2/1.3)
- **Environment variables** para credenciais
- **Non-root users** nos containers
- **Network isolation** entre serviços
- **Security headers** configurados

### ⚙️ **Automação e DevOps**
- **Docker Compose** para orquestração
- **Makefile** para automação de comandos
- **Health checks** e restart policies
- **Logs centralizados** e monitoramento

### 🗃️ **Banco de Dados**
- Interface de administração com Adminer
- Uso de volumes persistentes
- Segurança com variáveis de ambiente e rede isolada

### 🕹️ **Web App Estático com Node.js**
- Servidor Node.js para conteúdo estático
- Integração com Docker e proxy reverso
- Jogo desenvolvido em HTML/CSS/JS puro

## 🚀 Como Usar

### Pré-requisitos
```bash
# Docker e Docker Compose instalados
docker --version
docker-compose --version
```

### Configuração
```bash
# 1. Clone o repositório
git clone https://github.com/eliandrosergio/42-inception.git
cd 42-inception/my01

# 2. Configure o domínio no /etc/hosts
echo "127.0.0.1 efaustin.42.fr" | sudo tee -a /etc/hosts

# 3. Crie os diretórios de dados
mkdir -p /home/elian/data/{mariadb,wordpress}
```

### Execução
```bash
# Construir e iniciar todos os serviços
make all

# Ou comandos individuais
make build    # Construir imagens
make up       # Iniciar containers
make down     # Parar containers
make re       # Reconstruir tudo
make logs     # Ver logs
```

### Acesso
- **Website**: https://efaustin.42.fr
- **WordPress Admin**: https://efaustin.42.fr/wp-admin
- **Adminer**: https://efaustin.42.fr:600
- **Game Website**: https://efaustin.42.fr:4444

## 📚 Recursos e Referências

### 🐳 **Docker & Containerization**
- [Docker Documentation](https://docs.docker.com/reference/) - Documentação oficial
- [Docker Compose Guide](https://docs.docker.com/compose/) - Orquestração de containers
- [Dockerfile Best Practices](https://sysdig.com/blog/dockerfile-best-practices/) - Práticas recomendadas
- [Container Security](https://docs.docker.com/engine/security/rootless/) - Segurança em containers

### 🌐 **Web Services**
- [NGINX Configuration](https://www.nginx.com/resources/wiki/start/topics/examples/full/) - Configuração avançada
- [WordPress CLI](https://developer.wordpress.org/cli/commands/) - Automação WordPress
- [PHP-FPM Configuration](https://gist.github.com/lidaobing/673798) - Configuração PHP-FPM
- [MariaDB Docker](https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/) - Banco de dados

### 🔧 **DevOps & Architecture**
- [Container Networking](https://iximiuz.com/en/posts/container-networking-is-simple/) - Redes Docker
- [Docker Anti-patterns](https://jpetazzo.github.io/2021/11/30/docker-build-container-images-antipatterns/) - O que evitar
- [PID 1 Problem](https://blog.phusion.nl/2015/01/20/docker-and-the-pid-1-zombie-reaping-problem/) - Processos em containers

## 💡 Pontos-Chave do Projeto

### 🎯 **Desafios Superados**
1. **Networking**: Comunicação entre containers via rede isolada
2. **Persistência**: Volumes compartilhados entre host e containers
3. **Segurança**: SSL/TLS, usuarios não-root, variáveis de ambiente
4. **Automação**: Scripts de inicialização e configuração automática
5. **Performance**: Otimização de imagens e configurações

### 🏆 **Boas Práticas Implementadas**
- ✅ **Separation of Concerns**: Cada serviço em seu próprio container
- ✅ **Immutable Infrastructure**: Containers rebuilding para mudanças
- ✅ **Configuration Management**: Environment variables e arquivos de config
- ✅ **Security First**: Princípio do menor privilégio aplicado
- ✅ **Monitoring**: Logs e health checks implementados

## 📈 Possíveis Melhorias (Bonus)

- 🔄 **Redis Cache** - Cache para WordPress (bonus)
- 📁 **FTP Server** - Acesso aos arquivos (bonus)
- 📊 **Monitoring** - Prometheus/Grafana (bonus extra)
- 🛡️ **Fail2Ban** - Proteção contra tentativas de login maliciosas (bonus extra)

## 🤝 Contribuições

Este projeto faz parte do currículo da **Escola 42** e tem fins educacionais. Contribuições e melhorias são bem-vindas!

## 📝 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para detalhes.

---

**Desenvolvido por [Eliandro Sérgio](https://github.com/eliandrosergio) - 42 Student**

> *"O conhecimento é a única coisa que cresce quando compartilhada"*
