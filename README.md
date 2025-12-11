# Wolkenkuckucksheim ☁️🏡

Automatisierte Einrichtung einer privaten Nextcloud-Instanz. Dieses Repository enthält Infrastructure-as-Code (IaC) für ein reproduzierbares, sicheres Deployment auf dem eigenen Server. Datensouveränität durch vollständige Kontrolle über die eigene Cloud-Infrastruktur.

## Projektübersicht

Wolkenkuckucksheim ist ein IaC-Projekt zur Automatisierung des Deployments einer privaten Nextcloud-Instanz. Ziel ist eine vollständig reproduzierbare und sichere Installation, die manuelle Konfigurationsschritte eliminiert.

**Kernmerkmale:**
- Reproduzierbares Deployment durch Infrastructure-as-Code
- Fokus auf Sicherheit und Datensouveränität
- Entwicklungsumgebung mit Devcontainer
- Docker-basierte Container-Infrastruktur

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

# Image bauen
docker build -t mein-image .
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

# Test-Container ausführen
docker run --rm hello-world

# Container-Ressourcen prüfen
docker system df
```

## Technologien

**Entwicklungsumgebung:**
- [Visual Studio Code Dev Containers](https://code.visualstudio.com/docs/devcontainers/containers)
- [Docker-in-Docker](https://github.com/devcontainers/features/tree/main/src/docker-in-docker)
- Ubuntu 24.04 LTS

**Container-Runtime:**
- Docker / Moby Engine
- Docker Compose (via Docker-in-Docker Feature)

## Externe Ressourcen

**Entwicklungswerkzeuge:**
- [Dev Containers Dokumentation](https://containers.dev/)
- [GitHub Codespaces Dokumentation](https://docs.github.com/en/codespaces)
- [Docker Dokumentation](https://docs.docker.com/)

**Container-Features:**
- [Docker-in-Docker Feature](https://github.com/devcontainers/features/tree/main/src/docker-in-docker)
- [VS Code Docker Extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)

**Nextcloud:**
- [Nextcloud Dokumentation](https://docs.nextcloud.com/)
- [Nextcloud Installation Guide](https://docs.nextcloud.com/server/latest/admin_manual/installation/)

## Lizenz

Siehe [LICENSE](LICENSE) Datei für Details.
