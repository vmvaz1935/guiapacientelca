# Guia do Paciente LCA - Clínica PACE

Guia interativo para pacientes em recuperação de reconstrução do Ligamento Cruzado Anterior (LCA).

## 📋 Sobre

Este guia foi desenvolvido para auxiliar pacientes durante o processo de reabilitação pós-cirúrgica do LCA, fornecendo informações claras e acessíveis sobre:

- **Fases da Recuperação**: Protocolo progressivo com metas e exercícios
- **Previsão de Retorno**: Timeline estimada para retorno às atividades
- **Orientações Práticas**: Cuidados gerais, atividades de vida diária e marcos importantes

## 🚀 Como Usar Localmente

Basta abrir o arquivo `index.html` em qualquer navegador moderno. Não requer instalação ou servidor.

## 📤 Deploy para GitHub Pages

### Pré-requisitos

1. Conta no GitHub
2. Git instalado no seu computador
3. Repositório `guialca` criado no GitHub (público)

### Passo a Passo

#### 1. Criar o Repositório no GitHub

1. Acesse: https://github.com/new
2. Nome do repositório: `guialca`
3. Visibilidade: **Público** (necessário para GitHub Pages gratuito)
4. **NÃO** marque "Add a README file" ou outras opções
5. Clique em "Create repository"

#### 2. Executar o Script de Deploy

**No Windows (PowerShell):**
```powershell
.\deploy.ps1
```

**No Linux/Mac ou Git Bash:**
```bash
chmod +x deploy.sh
./deploy.sh
```

O script irá:
- ✅ Verificar e configurar o Git
- ✅ Criar o commit inicial
- ✅ Configurar o remote do GitHub
- ✅ Fazer push para o repositório

#### 3. Ativar o GitHub Pages

1. Acesse: `https://github.com/SEU_USUARIO/guialca/settings/pages`
2. Em **Source**, selecione:
   - Branch: `main`
   - Folder: `/ (root)`
3. Clique em **Save**

#### 4. Acessar sua Página

Sua página estará disponível em:
```
https://SEU_USUARIO.github.io/guialca/
```

⏱️ Pode levar alguns minutos para a página ficar online após ativar o GitHub Pages.

## 🛠️ Tecnologias Utilizadas

- React (via CDN)
- Tailwind CSS
- HTML5
- JavaScript (ES6+)

## 🏥 Desenvolvido por

**Vitor da Mata Vaz**  
Fisioterapeuta - CREFITO-3/297100-F  
Clínica PACE

## 📝 Nota Importante

*Este guia é um auxílio e não substitui suas consultas. Sempre siga a orientação direta do seu fisioterapeuta.*

## 📄 Licença

Este projeto é propriedade da Clínica PACE.
