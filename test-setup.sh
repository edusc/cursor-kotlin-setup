#!/bin/bash

# =============================================================================
# Script de Teste para Configuração Cursor IDE
# =============================================================================
# Testa os scripts em um projeto de exemplo
# =============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TEST_DIR="/tmp/test-cursor-kotlin-$(date +%s)"

echo "🧪 Testando configuração do Cursor IDE..."
echo "Diretório de teste: $TEST_DIR"

# Criar projeto de teste
mkdir -p "$TEST_DIR"
cd "$TEST_DIR"

# Criar estrutura básica de projeto Gradle Kotlin
cat > build.gradle.kts << 'EOF'
plugins {
    kotlin("jvm") version "1.9.24"
    id("org.springframework.boot") version "3.5.6"
    id("org.jlleitschuh.gradle.ktlint") version "12.3.0"
}

group = "com.example"
version = "0.0.1-SNAPSHOT"

repositories {
    mavenCentral()
}

dependencies {
    implementation(kotlin("stdlib"))
    implementation("org.springframework.boot:spring-boot-starter")
}
EOF

# Criar gradlew mock
echo '#!/bin/bash' > gradlew
echo 'echo "Gradle wrapper executado com: $@"' >> gradlew
chmod +x gradlew

# Criar classe principal mock
mkdir -p src/main/kotlin/com/example
cat > src/main/kotlin/com/example/Application.kt << 'EOF'
package com.example

import org.springframework.boot.autoconfigure.SpringBootApplication
import org.springframework.boot.runApplication

@SpringBootApplication
class Application

fun main(args: Array<String>) {
    runApplication<Application>(*args)
}
EOF

echo "✅ Projeto de teste criado"

# Executar configuração
echo "🚀 Executando configuração completa..."
"$SCRIPT_DIR/setup-cursor-kotlin-gradle.sh" "$TEST_DIR"

# Verificar resultados
echo ""
echo "🔍 Verificando arquivos criados:"
echo ""

if [ -d "$TEST_DIR/.vscode" ]; then
    echo "✅ Pasta .vscode criada"
    ls -la "$TEST_DIR/.vscode/"
else
    echo "❌ Pasta .vscode não encontrada"
fi

echo ""
echo "📁 Arquivos de configuração:"
for file in extensions.json settings.json tasks.json launch.json keybindings.json README-CURSOR.md; do
    if [ -f "$TEST_DIR/.vscode/$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (faltando)"
    fi
done

# Limpar
echo ""
echo "🧹 Limpando arquivos de teste..."
rm -rf "$TEST_DIR"

echo ""
echo "🎉 Teste concluído!"
