# 🚀 Cursor IDE Setup para Kotlin/Gradle

Scripts automatizados para configurar o **Cursor IDE** com todas as funcionalidades do **IntelliJ** para projetos Kotlin/Gradle.

[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](VERSION)
[![Kotlin](https://img.shields.io/badge/kotlin-supported-orange.svg)](https://kotlinlang.org/)
[![Gradle](https://img.shields.io/badge/gradle-supported-green.svg)](https://gradle.org/)
[![macOS](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](README.md)

## 🎯 **O que faz?**

Transforma qualquer projeto Kotlin/Gradle para funcionar **perfeitamente** no Cursor IDE com:

- ✅ **Ktlint** automático (formatação igual ao IntelliJ)
- ✅ **Build/Test/Run** integrados com atalhos
- ✅ **Debug** configurado e funcionando
- ✅ **Auto-complete** Kotlin completo
- ✅ **Detecção automática** do ambiente (JAVA_HOME, SDKMAN)
- ✅ **Atalhos de teclado** idênticos ao IntelliJ

## 🚀 **Uso Rápido**

```bash
# 1. Clonar o repositório
git clone <seu-repositorio>
cd cursor-kotlin-setup

# 2. Tornar executável
chmod +x *.sh

# 3. Configurar projeto (escolha uma opção)

# Opção A: Projeto atual
./setup-cursor-kotlin-gradle.sh

# Opção B: Projeto específico
./setup-cursor-kotlin-gradle.sh /caminho/para/meu-projeto

# 4. Abrir no Cursor
cursor .
```

## 📦 **Instalação Global (Recomendado)**

Para usar os scripts em qualquer projeto:

```bash
# Executar instalador interativo
./install.sh

# OU criar links manuais
sudo ln -sf "$(pwd)/setup-cursor-kotlin-gradle.sh" /usr/local/bin/cursor-kotlin-setup
sudo ln -sf "$(pwd)/quick-cursor-setup.sh" /usr/local/bin/cursor-kotlin-quick

# Usar de qualquer lugar
cd meu-projeto-kotlin
cursor-kotlin-setup
```

## ⚡ **Scripts Disponíveis**

| Script | Descrição | Uso |
|--------|-----------|-----|
| `setup-cursor-kotlin-gradle.sh` | **Configuração completa** (recomendado) | `./setup-cursor-kotlin-gradle.sh [projeto]` |
| `quick-cursor-setup.sh` | **Configuração básica** (rápida) | `./quick-cursor-setup.sh [projeto]` |
| `install.sh` | **Instalador global** interativo | `./install.sh` |
| `test-setup.sh` | **Testador** dos scripts | `./test-setup.sh` |
| `share-package.sh` | **Empacotador** para compartilhamento | `./share-package.sh` |

## ⌨️ **Atalhos Configurados**

Após a configuração, use os mesmos atalhos do IntelliJ:

- `Cmd+Shift+B` → **Build** do projeto
- `Cmd+Shift+T` → **Executar testes**
- `Cmd+Shift+F` → **Formatar código** (ktlint)
- `Cmd+Shift+L` → **Verificar lint**
- `Cmd+Shift+R` → **Executar aplicação**

## 🎛️ **Tasks Disponíveis**

Acesse via `Cmd+Shift+P` → "Tasks: Run Task":

- **Gradle: Build** - Build completo
- **Gradle: Clean Build** - Clean + Build  
- **Gradle: Test** - Executar todos os testes
- **Gradle: ktlint Check** - Verificar formatação
- **Gradle: ktlint Format** - Formatar automaticamente
- **Gradle: Boot Run** - Executar Spring Boot
- **Gradle: Jacoco Test Report** - Relatório de cobertura

## 🔧 **Detecção Automática**

Os scripts detectam automaticamente:

- ✅ **JAVA_HOME** (incluindo SDKMAN)
- ✅ **Classe principal** da aplicação
- ✅ **Tipo de projeto** (Spring Boot, app simples, etc.)
- ✅ **Nome do projeto**
- ✅ **Estrutura Gradle** existente

## 📁 **O que é Criado**

```
seu-projeto/
└── .vscode/
    ├── extensions.json      # Extensões recomendadas
    ├── settings.json        # Configurações do editor
    ├── tasks.json          # Tasks do Gradle
    ├── launch.json         # Configurações de debug
    ├── keybindings.json    # Atalhos de teclado
    └── README-CURSOR.md    # Documentação específica
```

## 🎯 **Exemplos de Uso**

### Configurar projeto existente
```bash
cd meu-projeto-spring-boot
cursor-kotlin-setup
cursor .
# ✅ Pronto! Ktlint, build, debug funcionando
```

### Novo projeto do zero
```bash
mkdir meu-servico && cd meu-servico
gradle init --type kotlin-application --dsl kotlin
cursor-kotlin-setup
cursor .
```

### Múltiplos projetos
```bash
for project in service-a service-b service-c; do
    cursor-kotlin-setup ~/projetos/$project
done
```

## 🚨 **Troubleshooting**

### Erro de JAVA_HOME
```bash
# Verificar JAVA_HOME
echo $JAVA_HOME

# Se usar SDKMAN, executar:
source ~/.sdkman/bin/sdkman-init.sh

# Tentar novamente
./setup-cursor-kotlin-gradle.sh
```

### Gradle não sincroniza
```bash
# No Cursor IDE:
Cmd+Shift+P → "Java: Reload Projects"
```

### Ktlint não funciona
```bash
# Verificar se está no build.gradle.kts:
plugins {
    id("org.jlleitschuh.gradle.ktlint") version "12.3.0"
}
```

### Script não executa
```bash
chmod +x *.sh
```

## 📋 **Requisitos**

- **Projeto**: Gradle com `gradlew`, `build.gradle` ou `build.gradle.kts`
- **Java**: JDK 17+ (preferencialmente via SDKMAN)
- **IDE**: Cursor IDE ou VS Code
- **SO**: macOS ou Linux

## 🧪 **Testar Configuração**

```bash
# Testar scripts
./test-setup.sh

# Verificar se funciona no projeto
cd seu-projeto
./gradlew build
cursor .
```

## 📤 **Compartilhar com Equipe**

### Método 1: Git (Recomendado)
```bash
# Sua equipe clona e usa
git clone <seu-repositorio>
cd cursor-kotlin-setup
./install.sh
```

### Método 2: Pacote
```bash
# Criar pacote para envio
./share-package.sh
# Envia arquivo .tar.gz gerado no Desktop
```

## 🔄 **Fluxo de Desenvolvimento**

1. **Configurar projeto**: `cursor-kotlin-setup`
2. **Abrir Cursor**: `cursor .`
3. **Aceitar extensões** quando solicitado
4. **Codificar** normalmente (auto-complete funciona)
5. **Formatar**: `Cmd+Shift+F` 
6. **Testar**: `Cmd+Shift+T`
7. **Build**: `Cmd+Shift+B`
8. **Debug**: `F5` (breakpoints funcionam)

## 📊 **IntelliJ vs Cursor (com estes scripts)**

| Funcionalidade | IntelliJ | Cursor + Scripts |
|---|:---:|:---:|
| Auto-complete Kotlin | ✅ | ✅ |
| Refactoring | ✅ | ✅ |
| Debug | ✅ | ✅ |
| Ktlint automático | ✅ | ✅ |
| Build integrado | ✅ | ✅ |
| Git integration | ✅ | ✅ |
| **AI assistente** | ❌ | ✅⭐ |
| **Performance** | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| **Custo** | 💰💰💰 | 🆓 |

## 🤝 **Contribuições**

1. Fork este repositório
2. Crie uma branch: `git checkout -b minha-feature`
3. Commit: `git commit -m 'Adiciona nova feature'`
4. Push: `git push origin minha-feature`
5. Abra um Pull Request

## 📄 **Licença**

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

## 🏷️ **Versão**

**Atual**: 1.0.0 - Primeira versão estável

---

## 🎯 **TL;DR - Uso Ultra-Rápido**

```bash
git clone <repo>
cd cursor-kotlin-setup
chmod +x *.sh
./setup-cursor-kotlin-gradle.sh /meu-projeto
cursor /meu-projeto
```

**🎉 Pronto! Kotlin/Gradle funcionando no Cursor como no IntelliJ!**

---

<p align="center">
  <strong>💡 Criado para maximizar produtividade no desenvolvimento Kotlin/Gradle</strong><br>
  <em>Transforme qualquer projeto em segundos!</em>
</p>