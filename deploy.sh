#!/bin/bash

# Script de Deploy para GitHub Pages - Guia LCA
# Execute este script após criar o repositório 'guialca' no GitHub

echo "🚀 Iniciando deploy do Guia LCA para GitHub Pages..."

# Verificar se o Git está instalado
if ! command -v git &> /dev/null; then
    echo "✗ Git não encontrado. Por favor, instale o Git primeiro."
    exit 1
fi

echo "✓ Git encontrado: $(git --version)"

# Verificar se já existe um repositório Git
if [ ! -d .git ]; then
    echo "📦 Inicializando repositório Git..."
    git init
fi

# Verificar configuração do Git
GIT_USER=$(git config user.name)
GIT_EMAIL=$(git config user.email)

if [ -z "$GIT_USER" ] || [ -z "$GIT_EMAIL" ]; then
    echo "⚙️  Configurando Git..."
    if [ -z "$GIT_USER" ]; then
        read -p "Digite seu nome para o Git: " userName
        git config user.name "$userName"
    fi
    if [ -z "$GIT_EMAIL" ]; then
        read -p "Digite seu email para o Git: " userEmail
        git config user.email "$userEmail"
    fi
fi

# Adicionar todos os arquivos
echo "📝 Adicionando arquivos..."
git add .

# Verificar se há mudanças para commitar
if [ -n "$(git status --porcelain)" ]; then
    echo "💾 Criando commit inicial..."
    git commit -m "Initial commit: Guia do Paciente LCA - Clínica PACE"
    echo "✓ Commit criado com sucesso!"
else
    echo "ℹ️  Nenhuma mudança para commitar."
fi

# Renomear branch para main (se necessário)
CURRENT_BRANCH=$(git branch --show-current)
if [ "$CURRENT_BRANCH" != "main" ]; then
    echo "🔄 Renomeando branch para 'main'..."
    git branch -M main
fi

# Verificar se o remote já existe
if ! git remote get-url origin &> /dev/null; then
    echo "🔗 Configurando remote do GitHub..."
    read -p "Digite seu usuário do GitHub (ex: mvito): " githubUser
    REPO_NAME="guialca"
    REMOTE_URL="https://github.com/$githubUser/$REPO_NAME.git"
    
    echo ""
    echo "⚠️  IMPORTANTE: Crie o repositório '$REPO_NAME' no GitHub primeiro!"
    echo "   Acesse: https://github.com/new"
    echo "   Nome do repositório: $REPO_NAME"
    echo "   Visibilidade: Público (necessário para GitHub Pages gratuito)"
    echo ""
    
    read -p "Já criou o repositório no GitHub? (s/n): " continue
    if [ "$continue" = "s" ] || [ "$continue" = "S" ]; then
        git remote add origin "$REMOTE_URL"
        echo "✓ Remote adicionado: $REMOTE_URL"
    else
        echo "⏸️  Execute este script novamente após criar o repositório."
        exit 0
    fi
else
    REMOTE_URL=$(git remote get-url origin)
    echo "✓ Remote já configurado: $REMOTE_URL"
    # Extrair usuário do remote URL
    githubUser=$(echo "$REMOTE_URL" | sed -n 's|.*github.com/\([^/]*\)/.*|\1|p')
fi

# Fazer push para o GitHub
echo "📤 Enviando para o GitHub..."
if git push -u origin main; then
    echo "✓ Push realizado com sucesso!"
else
    echo "✗ Erro ao fazer push. Verifique suas credenciais do GitHub."
    echo "  Você pode precisar configurar um Personal Access Token."
    exit 1
fi

# Instruções finais
echo ""
echo "============================================================"
echo "✅ Deploy concluído com sucesso!"
echo "============================================================"
echo ""
echo "📋 Próximos passos para ativar o GitHub Pages:"
echo ""
echo "1. Acesse: https://github.com/$githubUser/guialca/settings/pages"
echo "2. Em 'Source', selecione:"
echo "   - Branch: main"
echo "   - Folder: / (root)"
echo "3. Clique em 'Save'"
echo ""
echo "🌐 Sua página estará disponível em:"
echo "   https://$githubUser.github.io/guialca/"
echo ""
echo "⏱️  Pode levar alguns minutos para a página ficar online."
echo ""

