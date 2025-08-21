# 42-inception | 🚀 Inception - Projeto 42

> **Virtualização de serviços com Docker: Uma infraestrutura completa em containers**

## 📋 Sobre o Projeto

O **Inception** é um projeto da escola **42 Luanda** que visa aprofundar conhecimentos em administração de sistemas através da tecnologia Docker. O desafio consiste em criar uma infraestrutura completa virtualizada usando containers Docker, implementando as melhores práticas de segurança e arquitetura.

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
         ├───────────────────────┼───────────────────────┤
         │              ┌─────────────────┐              │
         │              │   ADMINER       │              │
         │              │  (DB Admin)     │              │
         │              │  Port: 9001     │              │
         │              └─────────────────┘              │
         │                       │                       │
         │              ┌─────────────────┐              │
         │              │   WEBSITE       │              │
         │              │  (Node.js)      │              │
         │              │  Port: 3000     │              │
         │              └─────────────────┘              │
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
- **Base**: Debian Bookworm Slim
- **Função**: Proxy reverso e terminação SSL
- **Características**:
  - Suporte **exclusivo** a TLS 1.2/1.3
  - Certificados SSL auto-assinados
  - Único ponto de entrada (porta 443)
  - Proxy reverso para Adminer e Website
  - Headers de segurança implementados
  - Configuração otimizada para PHP-FPM

### 🌍 **WordPress Container**
- **Base**: Debian Bookworm Slim
- **Função**: CMS e aplicação web
- **Características**:
  - PHP 8.2 com FPM
  - WordPress CLI (wp-cli) para automação
  - Configuração automática na inicialização
  - Tema personalizado (Teluro)
  - **Dois usuários**: Admin (edit_efaustin) + Author (edit_bivanio)

### 🗄️ **MariaDB Container**
- **Base**: Debian Bookworm Slim
- **Função**: Sistema de gerenciamento de banco de dados
- **Características**:
  - Configuração automática do banco WordPress
  - Usuário dedicado (efaustin) para WordPress
  - Persistência de dados via volumes
  - Configuração de segurança implementada
  - Uso de Docker Secrets para senhas

### 🛠️ **Adminer Container (Bonus)**
- **Base**: Debian Bookworm Slim
- **Função**: Interface web para gerenciamento do MariaDB
- **Características**:
  - PHP 8.2 com FPM na porta 9001
  - Interface leve e intuitiva
  - Acessível via **https://efaustin.42.fr/adminer/**
  - Conexão direta com MariaDB
  - Container isolado sem portas expostas

### 🌐 **Website Portfolio Container (Bonus)**
- **Base**: Debian Bookworm Slim
- **Função**: Portfolio pessoal em Node.js
- **Características**:
  - Servidor Node.js + Express na porta 3000
  - Website responsivo com HTML/CSS/JS
  - Portfolio de Eliandro Sérgio Francisco Faustino
  - Acessível via **https://efaustin.42.fr/website/**
  - Volume persistente para arquivos

## 📂 Estrutura do Projeto

```
inception/
├── Makefile                          # Automação do projeto
├── secrets/                          # Docker secrets (credenciais)
│   ├── credentials.txt
│   ├── db_password.txt
│   └── db_root_password.txt
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
│           ├── adminer/
│           │   ├── Dockerfile
│           │   ├── conf/
│           │   │   └── www.conf
│           │   └── tools/
│           │       └── run.sh
│           └── website/
│               ├── Dockerfile
│               └── tools/
│                   ├── server.js
│                   ├── index.html
│                   ├── style.css
│                   ├── package.json
│                   └── run.sh
└── /home/efaustin/data/               # Volumes persistentes
    ├── mariadb/
    ├── wordpress/
    └── website/
```

## 🛠️ Tecnologias e Conceitos Aplicados

### 🐳 **Docker & Container Technology**
- **Dockerfiles customizados** para cada serviço
- **Docker Compose** para orquestração
- **Container networking** com bridge driver
- **Volume management** para persistência
- **Docker Secrets** para credenciais seguras
- **Security best practices** implementadas

### 🔒 **Segurança**
- **SSL/TLS exclusivo** (1.2/1.3)
- **Docker Secrets** para credenciais sensíveis
- **Non-root users** nos containers
- **Network isolation** entre serviços
- **Security headers** configurados no nginx
- **Único ponto de entrada** via nginx (porta 443)

### ⚙️ **Automação e DevOps**
- **Docker Compose v3.3** para orquestração
- **Makefile** completo para automação
- **Health checks** e restart policies
- **Logs centralizados** e monitoramento
- **Volume bind mounts** para persistência

### 🌐 **Web Services**
- **Proxy Reverso** nginx para múltiplos serviços
- **PHP-FPM** otimizado para WordPress
- **Node.js + Express** para website estático
- **FastCGI** para Adminer

## 🚀 Como Usar

### Pré-requisitos
```bash
# Docker e Docker Compose v2 instalados
docker --version
docker compose version  # Note: sem hífen (v2)
```

### Configuração
```bash
# 1. Clone o repositório
git clone <seu-repositorio>
cd inception

# 2. Configure o domínio no /etc/hosts
echo "127.0.0.1 efaustin.42.fr" | sudo tee -a /etc/hosts

# 3. Os diretórios de dados são criados automaticamente pelo Makefile
```

### Execução
```bash
# Construir e iniciar todos os serviços
make all

# Ou comandos individuais
make build       # Construir imagens
make up          # Iniciar containers
make down        # Parar containers
make re          # Reconstruir tudo
make logs        # Ver logs de todos os serviços
make status      # Ver status dos containers
make deepclean   # Limpeza completa
```

### Acesso
- **WordPress**: https://efaustin.42.fr
- **WordPress Admin**: https://efaustin.42.fr/wp-admin
  - **Admin**: `edit_efaustin` / `edit_efaustin2004`
  - **Author**: `edit_bivanio` / `user_bivanio2010`
- **Adminer**: https://efaustin.42.fr/adminer/
- **Portfolio**: https://efaustin.42.fr/website/

## 📚 Recursos e Referências

### 🐳 **Docker & Containerization**
- [Docker Documentation](https://docs.docker.com/reference/) - Documentação oficial
- [Docker Compose Guide](https://docs.docker.com/compose/) - Orquestração de containers
- [Dockerfile Best Practices](https://docs.docker.com/develop/dev-best-practices/) - Práticas recomendadas
- [Docker Secrets](https://docs.docker.com/engine/swarm/secrets/) - Gerenciamento seguro de credenciais

### 🌐 **Web Services**
- [NGINX Configuration](https://nginx.org/en/docs/) - Documentação oficial nginx
- [WordPress CLI](https://wp-cli.org/) - Automação WordPress
- [PHP-FPM Configuration](https://www.php.net/manual/en/install.fpm.php) - Configuração PHP-FPM
- [MariaDB Docker](https://mariadb.com/kb/en/installing-and-using-mariadb-via-docker/) - Banco de dados
- [Node.js & Express](https://expressjs.com/) - Framework web Node.js

### 🔧 **DevOps & Architecture**
- [Container Networking](https://docs.docker.com/network/) - Redes Docker
- [Docker Volumes](https://docs.docker.com/storage/volumes/) - Persistência de dados
- [SSL/TLS Best Practices](https://ssl-config.mozilla.org/) - Configuração SSL

## 💡 Pontos-Chave do Projeto

### 🎯 **Desafios Superados**
1. **Networking**: Comunicação entre containers via rede isolada
2. **Persistência**: Volumes compartilhados entre host e containers
3. **Segurança**: SSL/TLS, Docker Secrets, usuários não-root
4. **Proxy Reverso**: nginx roteando múltiplos serviços
5. **Automação**: Scripts de inicialização e configuração automática

### 🏆 **Boas Práticas Implementadas**
- ✅ **Separation of Concerns**: Cada serviço em seu próprio container
- ✅ **Single Entry Point**: nginx como único ponto de entrada
- ✅ **Configuration Management**: Environment variables e Docker Secrets
- ✅ **Security First**: Princípio do menor privilégio aplicado
- ✅ **Monitoring**: Logs estruturados e health checks
- ✅ **Clean Architecture**: Containers sem portas expostas desnecessárias

## 🎓 Requisitos do Subject Atendidos

### ✅ **Mandatory Part**
- ✅ Nginx container com TLSv1.2/1.3 apenas
- ✅ WordPress + PHP-FPM (sem nginx)
- ✅ MariaDB (sem nginx)
- ✅ Volumes para database e website files
- ✅ Docker network conectando containers
- ✅ Containers reiniciam automaticamente
- ✅ Domínio efaustin.42.fr configurado
- ✅ Nginx único ponto de entrada (porta 443)
- ✅ Docker Secrets para senhas
- ✅ Usuários database sem nomes 'admin'

### ✅ **Bonus Part**
- ✅ **Adminer**: Interface web para database
- ✅ **Website estático**: Portfolio em Node.js (não PHP)
- ✅ Cada serviço bonus em container próprio
- ✅ Volumes dedicados quando necessário

## 🇦🇴 Desenvolvido por

**Eliandro Sérgio Francisco Faustino**
- 📅 Nascido em 3 de Outubro de 2004
- 🎓 Estudante da **42 Luanda**, Angola
- 📧 eliandrosergio42@gmail.com
- 🌍 Luanda, Angola

---

> *"A tecnologia é a ponte que une sonhos à realidade. 🌍✨"*

**Projeto desenvolvido como parte do currículo da 42 School**
