# Wolkenkuckucksheim ☁️🏡

Automatisierte Einrichtung einer privaten Nextcloud-Instanz. Dieses Repository enthält Infrastructure-as-Code (IaC) für ein reproduzierbares, sicheres Deployment auf dem eigenen Server. Datensouveränität durch vollständige Kontrolle über die eigene Cloud-Infrastruktur.

## Projektübersicht

Wolkenkuckucksheim ist ein IaC-Projekt zur Automatisierung des Deployments einer privaten Nextcloud-Instanz. Ziel ist eine vollständig reproduzierbare und sichere Installation, die manuelle Konfigurationsschritte eliminiert.

**Kernmerkmale:**
- Reproduzierbares Deployment durch Infrastructure-as-Code
- Docker Compose basierte Service-Orchestrierung
- Fokus auf Sicherheit und Datensouveränität
- Entwicklungsumgebung mit Devcontainer
- Vollständige Nextcloud-Stack-Definition (App, Datenbank, Cache)

## Repository-Struktur

```
wolkenkuckucksheim/
├── .devcontainer/          # Development Container Konfiguration
│   └── devcontainer.json   # VS Code Devcontainer Einstellungen
├── docker/                 # Docker Compose Infrastruktur
│   ├── docker-compose.yml  # Service-Definitionen (Nextcloud, PostgreSQL, Redis)
│   └── .env.example        # Template für Umgebungsvariablen
├── AGENTS.md              # Entwicklungs-Guidelines für AI Agents
├── README.md              # Projekt-Dokumentation (diese Datei)
├── LICENSE                # MIT Lizenz
└── .gitignore            # Git Ignore-Muster
```

### Verzeichnisse

- **`.devcontainer/`**: Konfiguration für die Entwicklungsumgebung (VS Code Dev Containers, GitHub Codespaces)
- **`docker/`**: Alle Docker Compose Dateien und Infrastruktur-Definitionen
  - Enthält Service-Definitionen für Nextcloud, PostgreSQL und Redis
  - Environment-Variable-Templates für Konfiguration

## Entwicklungsumgebung

### Voraussetzungen

- Visual Studio Code mit [Dev Containers Extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- Docker Desktop oder kompatible Container-Runtime
- Alternativ: Zugriff auf [GitHub Codespaces](https://github.com/features/codespaces)

### Devcontainer Setup

Das Projekt nutzt eine vorkonfigurierte Entwicklungsumgebung (Devcontainer) für konsistente Entwicklungsbedingungen.

**Devcontainer starten:**

```bash
# In VS Code: Command Palette öffnen (Ctrl+Shift+P / Cmd+Shift+P)
# Dann: "Dev Containers: Reopen in Container" auswählen
```

Alternativ öffnet VS Code automatisch einen Dialog beim Öffnen des Projekts.

**Technische Details:**
- Base Image: `mcr.microsoft.com/vscode/devcontainers/base:ubuntu-24.04`
- Container Runtime: Docker-in-Docker (Moby Engine)
- Primärer Benutzer: `vscode`

### GitHub Codespaces

Für cloudbasierte Entwicklung:

```bash
# Auf GitHub: Code → Codespaces → Create codespace on main
```

Der Codespace wird automatisch mit der korrekten Entwicklungsumgebung konfiguriert.

## Docker Compose Stack

Der gesamte Nextcloud-Stack wird mit Docker Compose definiert und verwaltet. Dies ermöglicht ein reproduzierbares, versioniertes Deployment.

### Services

Der Stack besteht aus folgenden Diensten:

#### Nextcloud Application (`app`)
- **Basis**: Official Nextcloud Docker Image
- **Port**: 8080 (Host) → 80 (Container)
- **Funktion**: Nextcloud Web-Interface und Anwendungsserver
- **Persistenz**: Nextcloud-Daten und Konfiguration in Docker Volume

#### PostgreSQL Database (`db`)
- **Basis**: PostgreSQL 16 Alpine
- **Funktion**: Relationale Datenbank für Nextcloud-Daten
- **Persistenz**: Datenbank-Dateien in Docker Volume
- **Optimierung**: Alpine-Image für minimalen Ressourcenverbrauch

#### Redis Cache (`redis`)
- **Basis**: Redis 7 Alpine
- **Funktion**: In-Memory Cache für Performance-Optimierung
- **Features**: File-Locking, Session-Management, Caching
- **Sicherheit**: Passwort-geschützte Redis-Instanz

### Nextcloud-Stack starten

```bash
# In das docker-Verzeichnis wechseln
cd docker/

# Umgebungsvariablen konfigurieren
cp .env.example .env
nano .env  # Passwörter und Konfiguration anpassen

# Stack starten
docker compose up -d

# Logs anzeigen
docker compose logs -f

# Status prüfen
docker compose ps
```

### Nextcloud-Stack verwalten

```bash
# Services neu starten
docker compose restart

# Stack stoppen
docker compose stop

# Stack stoppen und Container entfernen
docker compose down

# Stack stoppen und Volumes entfernen (ACHTUNG: Datenverlust!)
docker compose down -v

# Konfiguration validieren
docker compose config
```

### Umgebungsvariablen

Die Konfiguration erfolgt über eine `.env`-Datei im `docker/`-Verzeichnis:

| Variable | Beschreibung | Beispiel |
|----------|--------------|----------|
| `POSTGRES_PASSWORD` | PostgreSQL Datenbank-Passwort | `sicheres_db_passwort` |
| `REDIS_PASSWORD` | Redis Cache-Passwort | `sicheres_redis_passwort` |
| `NEXTCLOUD_ADMIN_USER` | Nextcloud Admin-Benutzername | `admin` |
| `NEXTCLOUD_ADMIN_PASSWORD` | Nextcloud Admin-Passwort | `sicheres_admin_passwort` |
| `NEXTCLOUD_TRUSTED_DOMAINS` | Vertrauenswürdige Domains | `localhost example.com` |

**Wichtig**: Die `.env`-Datei enthält sensible Daten und wird nicht in Git committet. Nutze `.env.example` als Template.

## Docker-in-Docker

Die Entwicklungsumgebung nutzt Docker-in-Docker zur Ausführung von Containern innerhalb des Devcontainers.

**Verfügbare Docker-Befehle:**

```bash
# Docker-Version prüfen
docker version

# Docker-Status anzeigen
docker info

# Container-Liste anzeigen
docker ps

# Test-Container ausführen
docker run hello-world

# Docker Compose nutzen
docker compose --version
```

**Konfiguration:**

Die Docker-in-Docker-Integration wird über das Feature `ghcr.io/devcontainers/features/docker-in-docker:2` bereitgestellt und nutzt die Moby Engine (Open-Source Docker).

## Setup-Anleitung

### Repository klonen

```bash
git clone https://github.com/CWiesbaum/wolkenkuckucksheim.git
cd wolkenkuckucksheim
```

### Entwicklungsumgebung starten

**Option 1: VS Code Devcontainer**

1. Repository in VS Code öffnen
2. Dialog "Reopen in Container" bestätigen oder Command Palette nutzen
3. Warten bis Container gebaut und gestartet ist

**Option 2: GitHub Codespaces**

1. Auf GitHub zum Repository navigieren
2. "Code" → "Codespaces" → "Create codespace" wählen
3. Automatisches Setup abwarten

### Docker-Funktionalität testen

Nach dem Start der Entwicklungsumgebung:

```bash
# Docker-Installation verifizieren
docker --version
docker compose version

# Test-Container ausführen
docker run --rm hello-world

# Container-Ressourcen prüfen
docker system df
```

## Schnellstart: Nextcloud lokal starten

Für einen schnellen Test des Nextcloud-Stacks:

```bash
# 1. Repository klonen (falls noch nicht geschehen)
git clone https://github.com/CWiesbaum/wolkenkuckucksheim.git
cd wolkenkuckucksheim

# 2. Entwicklungsumgebung starten (VS Code oder Codespace)
# Dann im Container:

# 3. Nextcloud-Stack konfigurieren
cd docker/
cp .env.example .env
# .env-Datei mit eigenen Passwörtern bearbeiten!

# 4. Stack starten
docker compose up -d

# 5. Warten bis alle Services bereit sind (ca. 30-60 Sekunden)
docker compose logs -f app

# 6. Nextcloud im Browser öffnen
# http://localhost:8080
```

**Erster Login:**
- Benutzername und Passwort aus `.env` verwenden (`NEXTCLOUD_ADMIN_USER` / `NEXTCLOUD_ADMIN_PASSWORD`)
- Bei erstem Start kann Nextcloud einige Minuten für die Initialisierung benötigen

## Technologien

**Entwicklungsumgebung:**
- [Visual Studio Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Docker-in-Docker](https://github.com/devcontainers/features/tree/main/src/docker-in-docker)
- Ubuntu 24.04 LTS

**Container-Runtime:**
- Docker / Moby Engine
- Docker Compose (via Docker-in-Docker Feature)

**Nextcloud-Stack:**
- [Nextcloud](https://nextcloud.com/) - Self-hosted Cloud-Lösung
- [PostgreSQL 16](https://www.postgresql.org/) - Relationale Datenbank
- [Redis 7](https://redis.io/) - In-Memory Cache und Session-Store

## Externe Ressourcen

**Entwicklungswerkzeuge:**
- [Dev Containers Dokumentation](https://containers.dev/)
- [GitHub Codespaces Dokumentation](https://docs.github.com/en/codespaces)
- [Docker Dokumentation](https://docs.docker.com/)
- [Docker Compose Dokumentation](https://docs.docker.com/compose/)

**Container-Features:**
- [Docker-in-Docker Feature](https://github.com/devcontainers/features/tree/main/src/docker-in-docker)
- [VS Code Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

**Nextcloud:**
- [Nextcloud Dokumentation](https://docs.nextcloud.com/)
- [Nextcloud Installation Guide](https://docs.nextcloud.com/server/latest/admin_manual/installation/)
- [Nextcloud Docker Image](https://hub.docker.com/_/nextcloud)
- [Nextcloud Performance Tuning](https://docs.nextcloud.com/server/latest/admin_manual/installation/server_tuning.html)

**Datenbank & Cache:**
- [PostgreSQL Dokumentation](https://www.postgresql.org/docs/)
- [Redis Dokumentation](https://redis.io/docs/)
- [Nextcloud mit Redis konfigurieren](https://docs.nextcloud.com/server/latest/admin_manual/configuration_server/caching_configuration.html)

## Lizenz

Siehe [LICENSE](LICENSE) Datei für Details.
