# 🎯 Exemplo Prático de Uso dos Scripts

## Cenário: Configurando um novo projeto

### 1. Projeto existente (como o offer-products-service)

```bash
# Navegar para o projeto
cd ~/Desenvolvimento/Workspaces/IF/offer-products-service

# Executar configuração completa
~/Desenvolvimento/Scripts/cursor-kotlin-setup/setup-cursor-kotlin-gradle.sh

# Resultado:
# ✅ Detecta Java 21 com SDKMAN
# ✅ Detecta classe principal: com.ifood.offer.OfferProductsApplicationKt
# ✅ Configura tasks completas com ktlint
# ✅ Cria atalhos de teclado
# ✅ Configura debug
```

### 2. Novo projeto do zero

```bash
# Criar novo projeto
mkdir meu-novo-servico
cd meu-novo-servico

# Inicializar Gradle Kotlin
gradle init --type kotlin-application --dsl kotlin --package com.example

# Configurar Cursor automaticamente
~/Desenvolvimento/Scripts/cursor-kotlin-setup/setup-cursor-kotlin-gradle.sh

# Abrir no Cursor
cursor .
```

### 3. Configuração rápida para múltiplos projetos

```bash
# Script para configurar vários projetos
for project in service-a service-b service-c; do
    echo "Configurando $project..."
    ~/Desenvolvimento/Scripts/cursor-kotlin-setup/setup-cursor-kotlin-gradle.sh ~/projetos/$project
done
```

## 📋 Checklist pós-configuração

### ✅ No Cursor IDE:
1. Abrir projeto (`cursor .` ou File > Open)
2. Aceitar instalação das extensões recomendadas
3. Aguardar sincronização do Gradle (pode demorar alguns minutos na primeira vez)
4. Verificar se não há erros na aba "Problems"

### ✅ Testar funcionalidades:
```bash
# Atalhos de teclado
Cmd+Shift+B  # Build
Cmd+Shift+T  # Test
Cmd+Shift+F  # Format
```

### ✅ Tasks no Command Palette:
```bash
Cmd+Shift+P > Tasks: Run Task
- Gradle: Build
- Gradle: Test  
- Gradle: ktlint Check
```

## 🎨 Personalização Avançada

### Modificar para projetos específicos:

```bash
# Para projetos sem Spring Boot
sed -i '' 's/bootRun/run/g' .vscode/tasks.json

# Para projetos com Maven (híbrido)
# Adicionar task Maven no tasks.json
```

### Adicionar tasks customizadas:

```json
// Em .vscode/tasks.json
{
  "label": "Docker Build",
  "type": "shell",
  "command": "docker build -t meu-app .",
  "group": "build"
}
```

## 🔄 Fluxo de Desenvolvimento

### Desenvolvimento diário:
1. `Cmd+Shift+F` - Formatar código ao iniciar
2. Codificar normalmente (auto-complete, navegação funcionam)
3. `Cmd+Shift+L` - Verificar ktlint antes de commit
4. `Cmd+Shift+T` - Rodar testes
5. `Cmd+Shift+B` - Build final

### Debug:
1. Colocar breakpoints no código
2. `F5` ou Debug > Start Debugging
3. Escolher configuração "Debug [Nome do Projeto]"

### Deploy/CI:
- As mesmas tasks funcionam no terminal: `./gradlew build`
- Configurações não afetam build em produção
- Compatible com pipelines existentes

## 🚨 Troubleshooting Comum

### Gradle não sincroniza:
```bash
# Forçar reload
Cmd+Shift+P > Java: Reload Projects

# Verificar JAVA_HOME
Cmd+Shift+P > Tasks: Run Task > Test: Java Environment
```

### Ktlint não funciona:
```bash
# Verificar se plugin está no build.gradle.kts
plugins {
    id("org.jlleitschuh.gradle.ktlint") version "X.X.X"
}

# Executar manualmente
./gradlew ktlintCheck
```

### Classes não encontradas:
```bash
# Aguardar indexação completa
# Verificar se todas as extensões Java estão ativas
# Limpar cache: Cmd+Shift+P > Java: Restart Language Server
```

## 📊 Comparação com IntelliJ

| Funcionalidade | IntelliJ | Cursor com Scripts |
|---|---|---|
| Auto-complete Kotlin | ✅ | ✅ |  
| Navegação de código | ✅ | ✅ |
| Refactoring | ✅ | ✅ |
| Build integrado | ✅ | ✅ |
| Ktlint automático | ✅ | ✅ |
| Debug | ✅ | ✅ |
| Git integration | ✅ | ✅ |
| Plugins ecosystem | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| AI assistente | ➖ | ✅⭐ |
| Performance | ⭐⭐⭐ | ⭐⭐⭐⭐ |

## 🎯 Próximos Passos

1. **Use os scripts** em seus projetos atuais
2. **Customize** conforme suas necessidades
3. **Compartilhe** com sua equipe
4. **Contribua** com melhorias nos scripts
5. **Automatize** com Git hooks ou CI/CD

---

*Scripts criados para maximizar produtividade no desenvolvimento Kotlin/Gradle com Cursor IDE* 🚀
