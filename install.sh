#!/bin/bash

# =============================================================================
# Instalador dos Scripts Cursor IDE para Kotlin/Gradle
# =============================================================================
# Este script instala os scripts de configuração do Cursor IDE globalmente
# =============================================================================

set -e

# Cores
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

print_status() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_header() {
    echo -e "${BLUE}"
    echo "=================================================="
    echo "  🚀 Instalador Cursor IDE Setup para Kotlin"
    echo "=================================================="
    echo -e "${NC}"
}

print_header

# Detecta o diretório atual (onde está o script)
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
print_info "Diretório dos scripts: $SCRIPT_DIR"

# Verifica se os scripts existem
if [ ! -f "$SCRIPT_DIR/setup-cursor-kotlin-gradle.sh" ]; then
    print_error "Script principal não encontrado!"
    exit 1
fi

if [ ! -f "$SCRIPT_DIR/quick-cursor-setup.sh" ]; then
    print_error "Script rápido não encontrado!"
    exit 1
fi

print_status "Scripts encontrados"

# Torna os scripts executáveis
chmod +x "$SCRIPT_DIR/setup-cursor-kotlin-gradle.sh"
chmod +x "$SCRIPT_DIR/quick-cursor-setup.sh"
print_status "Permissões de execução configuradas"

# Opções de instalação
echo ""
print_info "Escolha o método de instalação:"
echo "1) Link simbólico em /usr/local/bin (requer sudo)"
echo "2) Adicionar ao PATH no shell"
echo "3) Apenas preparar scripts (sem instalação global)"
echo ""
read -p "Digite sua opção (1-3): " choice

case $choice in
    1)
        print_info "Criando links simbólicos..."
        
        # Verifica se /usr/local/bin existe
        if [ ! -d "/usr/local/bin" ]; then
            print_warning "/usr/local/bin não existe, criando..."
            sudo mkdir -p /usr/local/bin
        fi
        
        # Cria links simbólicos
        sudo ln -sf "$SCRIPT_DIR/setup-cursor-kotlin-gradle.sh" /usr/local/bin/cursor-kotlin-setup
        sudo ln -sf "$SCRIPT_DIR/quick-cursor-setup.sh" /usr/local/bin/cursor-kotlin-quick
        
        print_status "Links criados:"
        print_info "  cursor-kotlin-setup - Configuração completa"
        print_info "  cursor-kotlin-quick - Configuração rápida"
        
        echo ""
        print_info "Uso:"
        echo "  cursor-kotlin-setup /caminho/do/projeto"
        echo "  cursor-kotlin-quick /caminho/do/projeto"
        ;;
        
    2)
        print_info "Adicionando ao PATH..."
        
        # Detecta o shell
        SHELL_RC=""
        if [ -n "$ZSH_VERSION" ] || [[ "$SHELL" == *"zsh"* ]]; then
            SHELL_RC="$HOME/.zshrc"
        elif [ -n "$BASH_VERSION" ] || [[ "$SHELL" == *"bash"* ]]; then
            SHELL_RC="$HOME/.bashrc"
        else
            print_warning "Shell não detectado, usando .zshrc"
            SHELL_RC="$HOME/.zshrc"
        fi
        
        # Adiciona ao PATH se ainda não estiver lá
        PATH_EXPORT="export PATH=\"$SCRIPT_DIR:\$PATH\""
        
        if ! grep -q "$SCRIPT_DIR" "$SHELL_RC" 2>/dev/null; then
            echo "" >> "$SHELL_RC"
            echo "# Cursor Kotlin Setup Scripts" >> "$SHELL_RC"
            echo "$PATH_EXPORT" >> "$SHELL_RC"
            print_status "Adicionado ao $SHELL_RC"
        else
            print_warning "Já existe no $SHELL_RC"
        fi
        
        print_info "Recarregue o shell ou execute:"
        echo "  source $SHELL_RC"
        echo ""
        print_info "Uso após recarregar:"
        echo "  setup-cursor-kotlin-gradle.sh /caminho/do/projeto"
        echo "  quick-cursor-setup.sh /caminho/do/projeto"
        ;;
        
    3)
        print_status "Scripts preparados para uso local"
        print_info "Uso:"
        echo "  $SCRIPT_DIR/setup-cursor-kotlin-gradle.sh /caminho/do/projeto"
        echo "  $SCRIPT_DIR/quick-cursor-setup.sh /caminho/do/projeto"
        ;;
        
    *)
        print_error "Opção inválida!"
        exit 1
        ;;
esac

# Teste de verificação
echo ""
print_info "🧪 Testando instalação..."

case $choice in
    1)
        if command -v cursor-kotlin-setup >/dev/null 2>&1; then
            print_status "Comando cursor-kotlin-setup disponível"
        else
            print_error "Comando não encontrado no PATH"
        fi
        ;;
    2)
        print_warning "Recarregue o shell para testar os comandos"
        ;;
    3)
        if [ -x "$SCRIPT_DIR/setup-cursor-kotlin-gradle.sh" ]; then
            print_status "Scripts executáveis configurados"
        fi
        ;;
esac

# Instruções finais
echo ""
print_header
print_status "✨ Instalação concluída!"
echo ""
print_info "📋 Para usar:"
print_info "1. Navegue até um projeto Kotlin/Gradle"
print_info "2. Execute o comando de configuração"
print_info "3. Abra o projeto no Cursor IDE"
print_info "4. Aceite as extensões recomendadas"
echo ""
print_info "📖 Documentação: $SCRIPT_DIR/README.md"
echo ""
print_info "🎯 Exemplo de uso:"
case $choice in
    1)
        echo "  cd meu-projeto"
        echo "  cursor-kotlin-setup"
        echo "  cursor ."
        ;;
    2|3)
        echo "  cd meu-projeto"
        echo "  setup-cursor-kotlin-gradle.sh"
        echo "  cursor ."
        ;;
esac
echo ""
print_status "Pronto para usar! 🚀"
