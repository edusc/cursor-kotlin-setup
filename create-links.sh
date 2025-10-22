#!/bin/bash

# =============================================================================
# Criador de Links Simbólicos para Scripts Cursor IDE
# =============================================================================
# Cria links simbólicos no PATH para acesso global aos scripts
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Criando links simbólicos para os scripts..."
echo "Pasta dos scripts: $SCRIPT_DIR"

# Cria links em /usr/local/bin
sudo ln -sf "$SCRIPT_DIR/setup-cursor-kotlin-gradle.sh" /usr/local/bin/cursor-kotlin-setup
sudo ln -sf "$SCRIPT_DIR/quick-cursor-setup.sh" /usr/local/bin/cursor-kotlin-quick

echo "✅ Links criados:"
echo "  cursor-kotlin-setup -> Configuração completa"
echo "  cursor-kotlin-quick -> Configuração rápida"
echo ""
echo "💡 Uso:"
echo "  cd meu-projeto"
echo "  cursor-kotlin-setup"
echo "  cursor ."
