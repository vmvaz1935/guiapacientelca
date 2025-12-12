# Script de Deploy para GitHub Pages - Guia LCA
# Execute este script após criar o repositório 'guialca' no GitHub

Write-Host "🚀 Iniciando deploy do Guia LCA para GitHub Pages..." -ForegroundColor Cyan

# Verificar se o Git está instalado
try {
    $gitVersion = git --version
    Write-Host "✓ Git encontrado: $gitVersion" -ForegroundColor Green
} catch {
    Write-Host "✗ Git não encontrado. Por favor, instale o Git primeiro." -ForegroundColor Red
    exit 1
}

# Verificar se já existe um repositório Git
if (-not (Test-Path .git)) {
    Write-Host "📦 Inicializando repositório Git..." -ForegroundColor Yellow
    git init
}

# Verificar configuração do Git
$gitUser = git config user.name
$gitEmail = git config user.email

if (-not $gitUser -or -not $gitEmail) {
    Write-Host "⚙️  Configurando Git..." -ForegroundColor Yellow
    if (-not $gitUser) {
        $userName = Read-Host "Digite seu nome para o Git"
        git config user.name $userName
    }
    if (-not $gitEmail) {
        $userEmail = Read-Host "Digite seu email para o Git"
        git config user.email $userEmail
    }
}

# Adicionar todos os arquivos
Write-Host "📝 Adicionando arquivos..." -ForegroundColor Yellow
git add .

# Verificar se há mudanças para commitar
$status = git status --porcelain
if ($status) {
    Write-Host "💾 Criando commit inicial..." -ForegroundColor Yellow
    git commit -m "Initial commit: Guia do Paciente LCA - Clínica PACE"
    Write-Host "✓ Commit criado com sucesso!" -ForegroundColor Green
} else {
    Write-Host "ℹ️  Nenhuma mudança para commitar." -ForegroundColor Blue
}

# Renomear branch para main (se necessário)
$currentBranch = git branch --show-current
if ($currentBranch -ne "main") {
    Write-Host "🔄 Renomeando branch para 'main'..." -ForegroundColor Yellow
    git branch -M main
}

# Verificar se o remote já existe
$remoteExists = git remote get-url origin 2>$null
if ($LASTEXITCODE -ne 0) {
    Write-Host "🔗 Configurando remote do GitHub..." -ForegroundColor Yellow
    $githubUser = Read-Host "Digite seu usuário do GitHub (ex: mvito)"
    $repoName = "guialca"
    $remoteUrl = "https://github.com/$githubUser/$repoName.git"
    
    Write-Host "⚠️  IMPORTANTE: Crie o repositório '$repoName' no GitHub primeiro!" -ForegroundColor Yellow
    Write-Host "   Acesse: https://github.com/new" -ForegroundColor Yellow
    Write-Host "   Nome do repositório: $repoName" -ForegroundColor Yellow
    Write-Host "   Visibilidade: Público (necessário para GitHub Pages gratuito)" -ForegroundColor Yellow
    Write-Host ""
    
    $continue = Read-Host "Já criou o repositório no GitHub? (s/n)"
    if ($continue -eq "s" -or $continue -eq "S") {
        git remote add origin $remoteUrl
        Write-Host "✓ Remote adicionado: $remoteUrl" -ForegroundColor Green
    } else {
        Write-Host "⏸️  Execute este script novamente após criar o repositório." -ForegroundColor Yellow
        exit 0
    }
} else {
    Write-Host "✓ Remote já configurado: $remoteExists" -ForegroundColor Green
}

# Fazer push para o GitHub
Write-Host "📤 Enviando para o GitHub..." -ForegroundColor Yellow
try {
    git push -u origin main
    Write-Host "✓ Push realizado com sucesso!" -ForegroundColor Green
} catch {
    Write-Host "✗ Erro ao fazer push. Verifique suas credenciais do GitHub." -ForegroundColor Red
    Write-Host "  Você pode precisar configurar um Personal Access Token." -ForegroundColor Yellow
    exit 1
}

# Instruções finais
Write-Host ""
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host "✅ Deploy concluído com sucesso!" -ForegroundColor Green
Write-Host "=" * 60 -ForegroundColor Cyan
Write-Host ""
Write-Host "📋 Próximos passos para ativar o GitHub Pages:" -ForegroundColor Yellow
Write-Host ""
Write-Host "1. Acesse: https://github.com/$githubUser/guialca/settings/pages" -ForegroundColor White
Write-Host "2. Em 'Source', selecione:" -ForegroundColor White
Write-Host "   - Branch: main" -ForegroundColor White
Write-Host "   - Folder: / (root)" -ForegroundColor White
Write-Host "3. Clique em 'Save'" -ForegroundColor White
Write-Host ""
Write-Host "🌐 Sua página estará disponível em:" -ForegroundColor Cyan
Write-Host "   https://$githubUser.github.io/guialca/" -ForegroundColor Green
Write-Host ""
Write-Host "⏱️  Pode levar alguns minutos para a página ficar online." -ForegroundColor Yellow
Write-Host ""

