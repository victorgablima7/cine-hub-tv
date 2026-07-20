# 🎬 Cine Hub TV

Hub pessoal de filmes para Android TV com catálogo do The Movie Database (TMDB).

## ✨ Features

- 🎬 **Catálogo completo** do TMDB (atualizado diariamente)
- 📂 **12 Categorias** bem divididas e coloridas
- 🔥 Filmes em alta, populares e mais bem avaliados
- 🔍 **Busca por título**
- 📺 **Trailers integrados** (YouTube)
- 📱 **Layout otimizado para TV** (D-pad / controle remoto)
- 🇧🇷 **Português do Brasil**

## 📲 Como baixar o APK

1. Acesse a aba **Actions** no topo deste repositório
2. Clique no build mais recente (✅ verde)
3. Role até **Artifacts** (no final da página)
4. Baixe `cine-hub-tv-apk.zip`
5. Descompacte e instale o `app-release.apk` na sua TV Box / Android TV

## 📲 Instalação na TV

1. Ative **Fontes desconhecidas** em `Configurações > Segurança`
2. Copie o APK (pendrive, USB, "Send Files to TV" ou ADB)
3. Instale e abra o **Cine Hub TV**
4. Divirta-se! 🍿

## 🔑 Configurar sua API key do TMDB (opcional)

O app vem com uma chave de demonstração. Para ter acesso estável:

1. Crie conta grátis em [themoviedb.org/signup](https://www.themoviedb.org/signup)
2. Solicite uma API key em [themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)
3. No app, vá em **⚙️ Configurações** e cole sua key

## 🛠️ Stack

- **Flutter** (Dart) — UI nativa e performática
- **TMDB API** — catálogo oficial
- **youtube_player_iframe** — trailers
- **GitHub Actions** — build automatizado

## 📂 Estrutura

```
lib/
├── main.dart
├── app.dart
├── theme/app_theme.dart
├── models/{movie,genre}.dart
├── services/tmdb_service.dart
├── screens/{home,category,movie_details,search,settings}_screen.dart
└── widgets/{movie_card,category_card,hero_banner}.dart
```

---

Cine Hub TV v1.0.0 · Dados via [The Movie Database (TMDB)](https://www.themoviedb.org/)
