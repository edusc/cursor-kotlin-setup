#!/bin/bash

# =============================================================================
# Setup Cursor IDE for Kotlin/Gradle Projects
# =============================================================================
# Este script configura automaticamente o Cursor IDE para projetos Kotlin/Gradle
# mantendo as funcionalidades do IntelliJ (ktlint, build, debug, etc.)
# 
# Uso: ./setup-cursor-kotlin-gradle.sh [CAMINHO_DO_PROJETO]
# Se não especificado, usa o diretório atual
# =============================================================================

set -e

# Cores para output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Função para print colorido
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
    echo "=============================================="
    echo "  🚀 Cursor IDE Setup for Kotlin/Gradle"
    echo "=============================================="
    echo -e "${NC}"
}

# Detecta o diretório do projeto
PROJECT_DIR="${1:-.}"
PROJECT_DIR=$(realpath "$PROJECT_DIR")

print_header

print_info "Configurando projeto em: $PROJECT_DIR"

# Verifica se é um projeto Gradle
if [ ! -f "$PROJECT_DIR/gradlew" ] && [ ! -f "$PROJECT_DIR/build.gradle" ] && [ ! -f "$PROJECT_DIR/build.gradle.kts" ]; then
    print_error "Este não parece ser um projeto Gradle!"
    print_info "Procurando por: gradlew, build.gradle ou build.gradle.kts"
    exit 1
fi

print_status "Projeto Gradle detectado"

# Detecta JAVA_HOME
if [ -n "$JAVA_HOME" ]; then
    DETECTED_JAVA_HOME="$JAVA_HOME"
    print_status "JAVA_HOME detectado: $DETECTED_JAVA_HOME"
else
    print_warning "JAVA_HOME não definido, usando java padrão do sistema"
    DETECTED_JAVA_HOME="/usr/lib/jvm/default-java"
fi

# Detecta se está usando SDKMAN
USING_SDKMAN=false
if [ -d "$HOME/.sdkman" ] && [[ "$JAVA_HOME" == *".sdkman"* ]]; then
    USING_SDKMAN=true
    print_status "SDKMAN detectado - configurações otimizadas serão aplicadas"
fi

# Detecta nome do projeto
PROJECT_NAME=$(basename "$PROJECT_DIR")
print_info "Nome do projeto: $PROJECT_NAME"

# Cria diretório .vscode
VSCODE_DIR="$PROJECT_DIR/.vscode"
mkdir -p "$VSCODE_DIR"
print_status "Diretório .vscode criado"

# Cria extensions.json
print_info "Criando configuração de extensões..."
cat > "$VSCODE_DIR/extensions.json" << 'EOF'
{
  "recommendations": [
    "mathiasfrohlich.Kotlin",
    "vscjava.vscode-gradle",
    "vscjava.vscode-java-pack",
    "redhat.java",
    "vscjava.vscode-java-dependency",
    "vscjava.vscode-java-test",
    "vscjava.vscode-maven",
    "ms-vscode.test-adapter-converter",
    "formulahendry.code-runner",
    "gabrielbb.vscode-lombok"
  ],
  "unwantedRecommendations": []
}
EOF
print_status "extensions.json criado"

# Cria settings.json
print_info "Criando configurações do editor..."
cat > "$VSCODE_DIR/settings.json" << EOF
{
  "java.configuration.updateBuildConfiguration": "automatic",
  "java.import.gradle.enabled": true,
  "java.import.gradle.wrapper.enabled": true,
  "java.import.maven.enabled": false,
  "java.configuration.maven.globalSettings": null,
  
  "gradle.nestedProjects": true,
  "gradle.autoDetect": "on",
  "gradle.disableConfirmations": true,
  
  "kotlin.languageServer.enabled": true,
  "kotlin.debounceTime": 250,
  "kotlin.completion.snippets.enabled": true,
  
  "java.compile.nullAnalysis.mode": "automatic",
  "java.codeGeneration.hashCodeEquals.useJava7Objects": true,
  "java.codeGeneration.useBlocks": true,
  
  "files.exclude": {
    "**/build": true,
    "**/.gradle": true,
    "**/gradle/wrapper": false,
    "**/node_modules": true
  },
  
  "search.exclude": {
    "**/build": true,
    "**/.gradle": true,
    "**/node_modules": true
  },
  
  "files.watcherExclude": {
    "**/build/**": true,
    "**/.gradle/**": true,
    "**/node_modules/**": true
  },
  
  "editor.formatOnSave": true,
  "editor.codeActionsOnSave": {
    "source.organizeImports": "explicit"
  },
  
  "kotlin.linting.run": "onSave",
  
  "[kotlin]": {
    "editor.defaultFormatter": "mathiasfrohlich.Kotlin",
    "editor.formatOnSave": true,
    "editor.tabSize": 4,
    "editor.insertSpaces": true,
    "editor.detectIndentation": false
  },
  
  "[java]": {
    "editor.defaultFormatter": "redhat.java",
    "editor.formatOnSave": true,
    "editor.tabSize": 4,
    "editor.insertSpaces": true
  },
  
  "terminal.integrated.defaultProfile.osx": "zsh",
  "terminal.integrated.shell.osx": "/bin/zsh",
  "terminal.integrated.shellArgs.osx": ["-l"],
  "terminal.integrated.env.osx": {
    "JAVA_HOME": "$DETECTED_JAVA_HOME"
  }
}
EOF
print_status "settings.json criado com JAVA_HOME: $DETECTED_JAVA_HOME"

# Cria tasks.json com configurações condicionais para SDKMAN
print_info "Criando tasks do Gradle..."

# Base das tasks
cat > "$VSCODE_DIR/tasks.json" << EOF
{
  "version": "2.0.0",
  "tasks": [
    {
      "label": "Gradle: Build",
      "type": "shell",
      "command": "./gradlew",
      "args": ["build"],
      "group": {
        "kind": "build",
        "isDefault": true
      },
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared",
        "showReuseMessage": true,
        "clear": false
      },
      "options": {
        "cwd": "\${workspaceFolder}",
        "env": {
          "JAVA_HOME": "$DETECTED_JAVA_HOME"
        }
      },
      "problemMatcher": [
        "\$gradle"
      ]
    },
    {
      "label": "Gradle: Clean Build",
      "type": "shell",
      "command": "./gradlew",
      "args": ["clean", "build"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "\${workspaceFolder}",
        "env": {
          "JAVA_HOME": "$DETECTED_JAVA_HOME"
        }
      },
      "problemMatcher": [
        "\$gradle"
      ]
    },
    {
      "label": "Gradle: Test",
      "type": "shell",
      "command": "./gradlew",
      "args": ["test"],
      "group": {
        "kind": "test",
        "isDefault": true
      },
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "\${workspaceFolder}",
        "env": {
          "JAVA_HOME": "$DETECTED_JAVA_HOME"
        }
      },
      "problemMatcher": [
        "\$gradle"
      ]
    },
    {
      "label": "Gradle: ktlint Check",
      "type": "shell",
      "command": "./gradlew",
      "args": ["ktlintCheck"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "\${workspaceFolder}",
        "env": {
          "JAVA_HOME": "$DETECTED_JAVA_HOME"
        }
      },
      "problemMatcher": [
        {
          "owner": "ktlint",
          "fileLocation": [
            "relative",
            "\${workspaceFolder}"
          ],
          "pattern": {
            "regexp": "^(.*):(\\\\d+):(\\\\d+):\\\\s+(warning|error):\\\\s+(.*)$",
            "file": 1,
            "line": 2,
            "column": 3,
            "severity": 4,
            "message": 5
          }
        }
      ]
    },
    {
      "label": "Gradle: ktlint Format",
      "type": "shell",
      "command": "./gradlew",
      "args": ["ktlintFormat"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "\${workspaceFolder}",
        "env": {
          "JAVA_HOME": "$DETECTED_JAVA_HOME"
        }
      }
    },
    {
      "label": "Gradle: Jacoco Test Report",
      "type": "shell",
      "command": "./gradlew",
      "args": ["jacocoTestReport"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "\${workspaceFolder}",
        "env": {
          "JAVA_HOME": "$DETECTED_JAVA_HOME"
        }
      }
    },
    {
      "label": "Gradle: Boot Run",
      "type": "shell",
      "command": "./gradlew",
      "args": ["bootRun"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "\${workspaceFolder}",
        "env": {
          "JAVA_HOME": "$DETECTED_JAVA_HOME"
        }
      },
      "isBackground": true
    }
EOF

# Adiciona tasks específicas do SDKMAN se detectado
if [ "$USING_SDKMAN" = true ]; then
    cat >> "$VSCODE_DIR/tasks.json" << 'EOF'
    ,
    {
      "label": "Gradle: Clean Build (SDKMAN)",
      "type": "shell",
      "command": "/bin/zsh",
      "args": ["-l", "-c", "source ~/.zshrc && ./gradlew clean build"],
      "group": "build",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "${workspaceFolder}"
      }
    },
    {
      "label": "Test: Java Environment",
      "type": "shell",
      "command": "/bin/zsh",
      "args": ["-c", "echo 'JAVA_HOME:' $JAVA_HOME && echo 'Java Version:' && java -version"],
      "group": "test",
      "presentation": {
        "echo": true,
        "reveal": "always",
        "focus": false,
        "panel": "shared"
      },
      "options": {
        "cwd": "${workspaceFolder}",
        "env": {
          "JAVA_HOME": "DETECTED_JAVA_HOME"
        }
      }
    }
EOF
fi

# Fecha o JSON das tasks
cat >> "$VSCODE_DIR/tasks.json" << 'EOF'
  ]
}
EOF

print_status "tasks.json criado"

# Detecta classe principal (heurística)
print_info "Detectando classe principal..."
MAIN_CLASS="com.example.Application"  # Default

# Procura por arquivos Kotlin com @SpringBootApplication ou fun main
if [ -d "$PROJECT_DIR/src/main/kotlin" ]; then
    MAIN_CLASS_FILE=$(find "$PROJECT_DIR/src/main/kotlin" -name "*.kt" -exec grep -l "@SpringBootApplication\|fun main" {} \; | head -1)
    if [ -n "$MAIN_CLASS_FILE" ]; then
        # Converte caminho do arquivo para nome da classe
        RELATIVE_PATH=${MAIN_CLASS_FILE#$PROJECT_DIR/src/main/kotlin/}
        MAIN_CLASS=${RELATIVE_PATH%.*}  # Remove .kt
        MAIN_CLASS=${MAIN_CLASS//\//.}  # Substitui / por .
        if [[ $MAIN_CLASS_FILE == *"Application.kt" ]]; then
            MAIN_CLASS="${MAIN_CLASS}Kt"  # Adiciona Kt para arquivos Kotlin com fun main
        fi
        print_status "Classe principal detectada: $MAIN_CLASS"
    fi
fi

# Cria launch.json
print_info "Criando configurações de debug..."
cat > "$VSCODE_DIR/launch.json" << EOF
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "java",
      "name": "Launch $PROJECT_NAME",
      "request": "launch",
      "mainClass": "$MAIN_CLASS",
      "projectName": "$PROJECT_NAME",
      "args": [],
      "env": {
        "SPRING_PROFILES_ACTIVE": "local"
      },
      "vmArgs": [
        "-Dspring.profiles.active=local"
      ]
    },
    {
      "type": "java",
      "name": "Debug $PROJECT_NAME",
      "request": "launch",
      "mainClass": "$MAIN_CLASS",
      "projectName": "$PROJECT_NAME",
      "args": [],
      "env": {
        "SPRING_PROFILES_ACTIVE": "local"
      },
      "vmArgs": [
        "-Dspring.profiles.active=local",
        "-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005"
      ]
    },
    {
      "type": "java",
      "name": "Launch Current File",
      "request": "launch",
      "mainClass": "\${file}"
    }
  ]
}
EOF
print_status "launch.json criado"

# Cria keybindings.json
print_info "Criando atalhos de teclado..."
cat > "$VSCODE_DIR/keybindings.json" << 'EOF'
[
  {
    "key": "cmd+shift+b",
    "command": "workbench.action.tasks.runTask",
    "args": "Gradle: Build"
  },
  {
    "key": "cmd+shift+t",
    "command": "workbench.action.tasks.runTask", 
    "args": "Gradle: Test"
  },
  {
    "key": "cmd+shift+f",
    "command": "workbench.action.tasks.runTask",
    "args": "Gradle: ktlint Format"
  },
  {
    "key": "cmd+shift+l",
    "command": "workbench.action.tasks.runTask",
    "args": "Gradle: ktlint Check"
  },
  {
    "key": "cmd+shift+r",
    "command": "workbench.action.tasks.runTask",
    "args": "Gradle: Boot Run"
  }
]
EOF
print_status "keybindings.json criado"

# Cria .editorconfig se não existir
if [ ! -f "$PROJECT_DIR/.editorconfig" ]; then
    print_info "Criando .editorconfig..."
    cat > "$PROJECT_DIR/.editorconfig" << 'EOF'
root = true

[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.{kt,kts}]
indent_style = space
indent_size = 4
continuation_indent_size = 4

[*.{java}]
indent_style = space
indent_size = 4

[*.{yml,yaml}]
indent_style = space
indent_size = 2

[*.{json}]
indent_style = space
indent_size = 2

[*.{gradle,gradle.kts}]
indent_style = space
indent_size = 4

[*.{sql}]
indent_style = space
indent_size = 2
EOF
    print_status ".editorconfig criado"
else
    print_warning ".editorconfig já existe - não foi alterado"
fi

# Cria documentação
print_info "Criando documentação..."
cat > "$VSCODE_DIR/README-CURSOR.md" << EOF
# Configuração do Cursor IDE para $PROJECT_NAME

Este projeto foi configurado automaticamente para funcionar no Cursor IDE.

## Gerado automaticamente em: $(date)

### Configurações Detectadas:
- **Projeto**: $PROJECT_NAME
- **JAVA_HOME**: $DETECTED_JAVA_HOME
- **SDKMAN**: $([ "$USING_SDKMAN" = true ] && echo "✅ Detectado" || echo "❌ Não detectado")
- **Classe Principal**: $MAIN_CLASS

## Atalhos de Teclado

- \`Cmd+Shift+B\` - Gradle: Build
- \`Cmd+Shift+T\` - Gradle: Test
- \`Cmd+Shift+F\` - Gradle: ktlint Format
- \`Cmd+Shift+L\` - Gradle: ktlint Check
- \`Cmd+Shift+R\` - Gradle: Boot Run

## Tasks Disponíveis (Cmd+Shift+P > Tasks: Run Task)

- **Gradle: Build** - Build completo do projeto
- **Gradle: Clean Build** - Limpa e reconstrói o projeto
- **Gradle: Test** - Executa todos os testes
- **Gradle: ktlint Check** - Verifica regras de estilo do código
- **Gradle: ktlint Format** - Formata o código automaticamente
- **Gradle: Jacoco Test Report** - Gera relatório de cobertura
- **Gradle: Boot Run** - Executa a aplicação Spring Boot
EOF

# Adiciona seção SDKMAN se detectado
if [ "$USING_SDKMAN" = true ]; then
    cat >> "$VSCODE_DIR/README-CURSOR.md" << 'EOF'
- **Gradle: Clean Build (SDKMAN)** - Versão que carrega ambiente SDKMAN completo
- **Test: Java Environment** - Testa configuração do Java/JAVA_HOME

## Configurações SDKMAN

Este projeto foi configurado para usar SDKMAN. Se houver problemas com JAVA_HOME:

1. Use a task "Test: Java Environment" para verificar a configuração
2. Use a task "Gradle: Clean Build (SDKMAN)" como alternativa
3. Verifique se o SDKMAN está configurado corretamente no seu shell
EOF
fi

cat >> "$VSCODE_DIR/README-CURSOR.md" << 'EOF'

## Funcionalidades Configuradas

### ✅ Ktlint Integration
- Formatação automática ao salvar
- Verificação de estilo em tempo real
- Problem matcher configurado para mostrar erros de lint

### ✅ Java/Kotlin Support
- Auto-complete completo
- Navegação entre classes
- Refactoring automático
- Detecção de erros em tempo real

### ✅ Gradle Integration
- Sincronização automática
- Execução de tasks integrada
- Resolução de dependências automática

### ✅ Debug Support
- Configurações de debug prontas
- Breakpoints funcionais
- Hot reload para desenvolvimento

## Como Usar

1. **Abra o projeto no Cursor** - Irá automaticamente detectar as configurações
2. **Aceite as extensões recomendadas** quando solicitado
3. **Aguarde a sincronização** do Gradle (primeira vez pode demorar alguns minutos)
4. **Comece a codificar!** - Tudo funcionará como no IntelliJ

## Troubleshooting

### Se o Gradle não sincronizar automaticamente:
1. Abra o Command Palette (`Cmd+Shift+P`)
2. Execute "Java: Reload Projects"

### Se o Kotlin não estiver funcionando:
1. Verifique se a extensão Kotlin está instalada
2. Reinicie o Cursor IDE

### Se o ktlint não estiver formatando:
1. Verifique se "Format on Save" está habilitado nas configurações
2. Execute manualmente com `Cmd+Shift+F`

---

*Configuração gerada automaticamente pelo script setup-cursor-kotlin-gradle.sh*
EOF

print_status "README-CURSOR.md criado"

# Resumo final
echo ""
print_header
print_status "✨ Configuração concluída com sucesso!"
echo ""
print_info "📁 Arquivos criados em $VSCODE_DIR:"
echo "   • extensions.json - Extensões recomendadas"
echo "   • settings.json - Configurações do editor"
echo "   • tasks.json - Tasks do Gradle"
echo "   • launch.json - Configurações de debug"
echo "   • keybindings.json - Atalhos de teclado"
echo "   • README-CURSOR.md - Documentação"
echo ""
if [ ! -f "$PROJECT_DIR/.editorconfig" ]; then
    echo "   • .editorconfig - Formatação de código"
fi
echo ""
print_info "🚀 Próximos passos:"
echo "   1. Abra o projeto no Cursor IDE"
echo "   2. Aceite as extensões recomendadas"
echo "   3. Aguarde a sincronização do Gradle"
echo "   4. Comece a usar os atalhos!"
echo ""
print_info "📖 Consulte o arquivo README-CURSOR.md para mais detalhes"
echo ""
