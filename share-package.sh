#!/bin/bash

# =============================================================================
# Empacotador para Compartilhamento
# =============================================================================
# Cria um pacote dos scripts para compartilhar com outras pessoas
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PACKAGE_NAME="cursor-kotlin-setup-$(date +%Y%m%d)"
OUTPUT_DIR="$HOME/Desktop"

echo "📦 Criando pacote de compartilhamento..."
echo "Nome do pacote: $PACKAGE_NAME"

# Criar pasta temporária
TEMP_DIR="/tmp/$PACKAGE_NAME"
mkdir -p "$TEMP_DIR"

# Copiar arquivos essenciais
cp "$SCRIPT_DIR/setup-cursor-kotlin-gradle.sh" "$TEMP_DIR/"
cp "$SCRIPT_DIR/quick-cursor-setup.sh" "$TEMP_DIR/"
cp "$SCRIPT_DIR/install.sh" "$TEMP_DIR/"
cp "$SCRIPT_DIR/README.md" "$TEMP_DIR/"
cp "$SCRIPT_DIR/EXAMPLE-USAGE.md" "$TEMP_DIR/"

# Criar arquivo de instruções rápidas
cat > "$TEMP_DIR/QUICK-START.md" << 'EOF'
# 🚀 Quick Start - Cursor IDE Setup para Kotlin/Gradle

## Instalação Rápida

```bash
# 1. Extrair arquivos
# 2. Tornar executável
chmod +x *.sh

# 3. Instalar globalmente (opcional)
./install.sh

# 4. Usar em qualquer projeto
./setup-cursor-kotlin-gradle.sh /caminho/do/projeto
```

## Uso Básico

1. Vá até seu projeto Kotlin/Gradle
2. Execute: `./setup-cursor-kotlin-gradle.sh`
3. Abra no Cursor: `cursor .`
4. Aceite as extensões recomendadas

## Atalhos Configurados

- `Cmd+Shift+B` → Build
- `Cmd+Shift+T` → Test
- `Cmd+Shift+F` → Format (ktlint)

## Suporte

- Documentação completa: `README.md`
- Exemplos: `EXAMPLE-USAGE.md`
EOF

# Tornar executáveis
chmod +x "$TEMP_DIR"/*.sh

# Criar pacote compactado
cd /tmp
tar -czf "$OUTPUT_DIR/$PACKAGE_NAME.tar.gz" "$PACKAGE_NAME"

# Criar pacote zip também
zip -r "$OUTPUT_DIR/$PACKAGE_NAME.zip" "$PACKAGE_NAME"

# Limpar
rm -rf "$TEMP_DIR"

echo "✅ Pacotes criados:"
echo "  📦 $OUTPUT_DIR/$PACKAGE_NAME.tar.gz"
echo "  📦 $OUTPUT_DIR/$PACKAGE_NAME.zip"
echo ""
echo "💡 Para compartilhar:"
echo "1. Envie um dos arquivos acima"
echo "2. A pessoa deve extrair e executar ./install.sh"
echo "3. Pronto para usar!"
