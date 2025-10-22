#!/bin/bash

# =============================================================================
# Inicializador Git - Cursor Kotlin Setup
# =============================================================================
# Prepara o repositório para Git com estrutura limpa
# =============================================================================

echo "🚀 Preparando repositório para Git..."

# Limpar arquivos de documentação redundantes
rm -f EXAMPLE-USAGE.md README-CURSOR-SETUP.md FINAL-SUMMARY.md 2>/dev/null || true

# Tornar scripts executáveis
chmod +x *.sh

# Inicializar git se não existir
if [ ! -d ".git" ]; then
    git init
    echo "✅ Git inicializado"
fi

# Adicionar arquivos ao git
git add .

# Mostrar status
echo ""
echo "📁 Estrutura final do repositório:"
echo "================================="
ls -la | grep -E '\.(sh|md|yml|gitignore|LICENSE|VERSION)$|^d'

echo ""
echo "📋 Próximos passos:"
echo "1. git commit -m \"feat: scripts cursor ide para kotlin/gradle\""
echo "2. git remote add origin <seu-repo-url>"
echo "3. git push -u origin main"
echo ""
echo "✅ Pronto para Git!"
