# 🚀 Scripts de Configuração do Cursor IDE para Kotlin/Gradle

Este conjunto de scripts automatiza a configuração do Cursor IDE para projetos Kotlin/Gradle, replicando a experiência do IntelliJ.

## 📋 Scripts Disponíveis

### 1. `setup-cursor-kotlin-gradle.sh` - **Configuração Completa**
Script principal com todas as funcionalidades:
- ✅ Detecção automática do ambiente (JAVA_HOME, SDKMAN, etc.)
- ✅ Configuração completa do ktlint
- ✅ Tasks do Gradle integradas
- ✅ Atalhos de teclado
- ✅ Configurações de debug
- ✅ Documentação automática
- ✅ Suporte ao SDKMAN
- ✅ Detecção da classe principal

### 2. `quick-cursor-setup.sh` - **Configuração Rápida**
Script simplificado para configuração básica:
- ✅ Extensões essenciais
- ✅ Configurações mínimas
- ✅ Tasks básicas (build/test)

## 🎯 Como Usar

### Configuração Completa (Recomendado)
```bash
# Para o projeto atual
./setup-cursor-kotlin-gradle.sh

# Para um projeto específico
./setup-cursor-kotlin-gradle.sh /caminho/para/meu-projeto

# Tornar executável (primeira vez)
chmod +x setup-cursor-kotlin-gradle.sh
```

### Configuração Rápida
```bash
# Para configuração básica
./quick-cursor-setup.sh [caminho-projeto]
```

## 📁 O que é Criado

### Configuração Completa:
```
.vscode/
├── extensions.json      # Extensões recomendadas
├── settings.json        # Configurações do editor
├── tasks.json          # Tasks do Gradle (build, test, ktlint, etc.)
├── launch.json         # Configurações de debug
├── keybindings.json    # Atalhos de teclado
└── README-CURSOR.md    # Documentação específica do projeto

.editorconfig           # Formatação de código (se não existir)
```

## ⚡ Funcionalidades

### Atalhos de Teclado Configurados:
- `Cmd+Shift+B` → Build
- `Cmd+Shift+T` → Test
- `Cmd+Shift+F` → ktlint Format
- `Cmd+Shift+L` → ktlint Check
- `Cmd+Shift+R` → Boot Run

### Tasks Disponíveis:
- **Gradle: Build** - Build completo
- **Gradle: Clean Build** - Clean + Build
- **Gradle: Test** - Executar testes
- **Gradle: ktlint Check** - Verificar formatação
- **Gradle: ktlint Format** - Formatar código
- **Gradle: Boot Run** - Executar aplicação
- **Gradle: Jacoco Test Report** - Relatório de cobertura

### Detecção Automática:
- ✅ JAVA_HOME do ambiente
- ✅ Configuração do SDKMAN
- ✅ Nome do projeto
- ✅ Classe principal da aplicação
- ✅ Estrutura do projeto Gradle

## 🛠️ Casos de Uso

### Para Novos Projetos:
```bash
# Criar projeto
gradle init --type kotlin-application

# Configurar Cursor
./setup-cursor-kotlin-gradle.sh

# Abrir no Cursor
cursor .
```

### Para Projetos Existentes:
```bash
# Entrar no projeto
cd meu-projeto-existente

# Configurar Cursor
/caminho/para/setup-cursor-kotlin-gradle.sh

# Abrir no Cursor
cursor .
```

### Para Múltiplos Projetos:
```bash
# Script para configurar vários projetos
for project in projeto1 projeto2 projeto3; do
    ./setup-cursor-kotlin-gradle.sh ~/projetos/$project
done
```

## 🔧 Personalização

### Modificar JAVA_HOME:
O script detecta automaticamente, mas você pode forçar:
```bash
JAVA_HOME=/meu/java ./setup-cursor-kotlin-gradle.sh
```

### Adicionar Tasks Personalizadas:
Edite o arquivo `.vscode/tasks.json` depois da configuração:
```json
{
  "label": "Minha Task Customizada",
  "type": "shell",
  "command": "./gradlew minhaTask"
}
```

## 📦 Instalação Global

Para usar os scripts de qualquer lugar:

```bash
# Copiar para PATH
sudo cp setup-cursor-kotlin-gradle.sh /usr/local/bin/
sudo cp quick-cursor-setup.sh /usr/local/bin/

# Tornar executáveis
sudo chmod +x /usr/local/bin/setup-cursor-kotlin-gradle.sh
sudo chmod +x /usr/local/bin/quick-cursor-setup.sh

# Usar de qualquer lugar
cd qualquer-projeto-kotlin
setup-cursor-kotlin-gradle.sh
```

## 🚨 Resolução de Problemas

### Script não executa:
```bash
chmod +x setup-cursor-kotlin-gradle.sh
```

### JAVA_HOME incorreto:
```bash
# Verificar
echo $JAVA_HOME

# Configurar (bash/zsh)
export JAVA_HOME=/caminho/correto

# Executar novamente
./setup-cursor-kotlin-gradle.sh
```

### Tasks não funcionam:
1. Verifique se o `gradlew` existe e é executável
2. Execute a task "Test: Java Environment" para debug
3. Use tasks com "(SDKMAN)" se estiver usando SDKMAN

## 📋 Requisitos

- Projeto Gradle (presença de `gradlew`, `build.gradle` ou `build.gradle.kts`)
- Java instalado (preferencialmente via SDKMAN)
- Cursor IDE ou VS Code
- macOS/Linux (adaptável para Windows)

## ✨ Vantagens

1. **Automático**: Detecta configurações do ambiente
2. **Reutilizável**: Use em qualquer projeto Kotlin/Gradle
3. **Completo**: Todas as funcionalidades do IntelliJ
4. **Flexível**: Configuração básica ou completa
5. **Documentado**: Cada projeto ganha sua documentação
6. **Versionado**: Mantém histórico das configurações

---

**💡 Dica**: Mantenha esses scripts em uma pasta no seu PATH para uso global, ou em um repositório Git para compartilhar com a equipe!
