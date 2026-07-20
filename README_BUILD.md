# 📦 Como gerar o APK

## Requisitos

1. **Flutter SDK** instalado (https://flutter.dev)
2. **Android Studio** (para o Android SDK e build tools)
3. **Java JDK 17+**

## Passo a passo

```bash
# 1. Entrar na pasta do projeto
cd cine-hub-tv

# 2. Instalar dependências
flutter pub get

# 3. Verificar ambiente
flutter doctor

# 4. Gerar APK release
flutter build apk --release

# 5. O APK vai estar em:
# build/app/outputs/flutter-apk/app-release.apk
```

## Instalar na TV

### Opção 1: USB / Pendrive
1. Copie o APK `app-release.apk` para um pendrive
2. Conecte na TV Box
3. Abra o gerenciador de arquivos
4. Clique no APK e instale

### Opção 2: ADB
```bash
adb connect <IP_DA_TV>
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Opção 3: Send Files to TV
Instale o app "Send Files to TV" na TV e no celular, transfira o APK e instale.

## ⚠️ Fontes desconhecidas

Lembre-se de ativar **Fontes desconhecidas** nas configurações da TV antes de instalar.

## 🔑 Configurar API key do TMDB

1. Crie conta grátis em https://www.themoviedb.org/signup
2. Vá em https://www.themoviedb.org/settings/api
3. Copie sua API key
4. No app, vá em **⚙️ Configurações** e cole sua key
5. Reinicie o app para aplicar
