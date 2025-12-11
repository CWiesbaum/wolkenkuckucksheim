# AI Agent Development Guide

This document provides guidance for AI agents working on the Wolkenkuckucksheim project.

## Development Environment

### Devcontainer

This project uses a devcontainer for consistent development environments. The devcontainer configuration is located in `.devcontainer/devcontainer.json`.

**Key features:**
- **Base Image**: mcr.microsoft.com/vscode/devcontainers/base:ubuntu-24.04
- **Primary User**: `vscode`
- **Container Runtime**: Docker-in-Docker
- **GitHub Codespaces**: Fully compatible and tested

**Setup:**
1. Open the project in VS Code with the Dev Containers extension
2. VS Code will prompt to reopen in container
3. Alternatively, use "Reopen in Container" from the command palette
4. For GitHub Codespaces, simply create a new codespace from the repository

### Container Runtime: Docker-in-Docker

This project uses **Docker-in-Docker** for running containers within the devcontainer.

**Important Configuration:**
- Docker is installed via the `ghcr.io/devcontainers/features/docker-in-docker:2` feature
- Uses Moby (the open-source Docker engine)
- Allows building and running containers inside the development container

**Usage:**
```bash
# Standard Docker commands
docker version
docker info
docker run hello-world
docker build -t myimage .
docker ps
```

**Key Features:**
- Full Docker CLI available in the devcontainer
- Build and test container images during development
- Compatible with all standard Docker commands and workflows

## Project Overview

Wolkenkuckucksheim is an Infrastructure-as-Code (IaC) project for automating the setup of a private Nextcloud instance. The goal is reproducible, secure deployment on a personal server with data sovereignty in mind.

## Development Guidelines

### Making Changes

1. **Use the devcontainer** for all development work
2. **Test with docker** for any container-related changes
3. **Keep configurations minimal** and well-documented
4. **Security first** - this project handles personal data infrastructure

### Testing Container Builds

When working with container images or builds:
```bash
# Use docker in the devcontainer
docker build -t test-image .
docker run --rm test-image
```

### File Organization

- Infrastructure code and configurations should be well-organized
- Use clear naming conventions
- Document any non-obvious configurations
- Keep secrets out of version control

## Troubleshooting

### Docker Issues

If you encounter Docker-related errors:
```bash
# Check Docker status
docker info

# Verify Docker is running
docker ps

# Clean up Docker resources (warning: removes all containers/images)
docker system prune -a
```

### Devcontainer Issues

If the devcontainer fails to build:
1. Check `.devcontainer/devcontainer.json` syntax
2. Review feature installation logs
3. Rebuild container from scratch (Command Palette > "Rebuild Container")

## Resources

- [Docker Documentation](https://docs.docker.com/)
- [Docker-in-Docker Feature](https://github.com/devcontainers/features/tree/main/src/docker-in-docker)
- [Dev Containers Documentation](https://containers.dev/)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
