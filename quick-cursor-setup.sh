#!/bin/bash

# =============================================================================
# Quick Cursor IDE Setup - Versão Simplificada
# =============================================================================
# Script rápido que aplica as configurações básicas do Cursor IDE
# Para projetos Kotlin/Gradle
# =============================================================================

PROJECT_DIR="${1:-.}"
PROJECT_DIR=$(realpath "$PROJECT_DIR")

echo "🚀 Configuração rápida do Cursor IDE para: $(basename "$PROJECT_DIR")"

# Verifica se é projeto válido
if [ ! -d "$PROJECT_DIR" ]; then
    echo "❌ Diretório não encontrado: $PROJECT_DIR"
    exit 1
fi

# Detecta JAVA_HOME
JAVA_HOME_PATH="${JAVA_HOME:-/usr/lib/jvm/default-java}"

# Cria .vscode se não existir
mkdir -p "$PROJECT_DIR/.vscode"

# Configuração mínima - extensions.json
cat > "$PROJECT_DIR/.vscode/extensions.json" << 'EOF'
{
  "recommendations": [
    "mathiasfrohlich.Kotlin",
    "vscjava.vscode-gradle",
    "vscjava.vscode-java-pack"
  ]
}
EOF

# Configuração mínima - settings.json
cat > "$PROJECT_DIR/.vscode/settings.json" << EOF
{
  "java.import.gradle.enabled": true,
  "gradle.autoDetect": "on",
  "kotlin.languageServer.enabled": true,
  "editor.formatOnSave": true,
  "[kotlin]": {
    "editor.tabSize": 4,
    "editor.insertSpaces": true
  },
  "terminal.integrated.env.osx": {
    "JAVA_HOME": "$JAVA_HOME_PATH"
  }
}
EOF

# Tasks básicas
cat > "$PROJECT_DIR/.vscode/tasks.json" << EOF
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Build",
      "type": "shell",
      "command": "./gradlew build",
      "group": {"kind": "build", "isDefault": true},
      "options": {"env": {"JAVA_HOME": "$JAVA_HOME_PATH"}}
    },
    {
      "label": "Test",
      "type": "shell", 
      "command": "./gradlew test",
      "group": {"kind": "test", "isDefault": true},
      "options": {"env": {"JAVA_HOME": "$JAVA_HOME_PATH"}}
    }
  ]
}
EOF

echo "✅ Configuração básica concluída!"
echo "💡 Para configuração completa, use: setup-cursor-kotlin-gradle.sh"
