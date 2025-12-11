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

## Architecture Guidelines

### Docker Compose Stack

The entire Nextcloud stack is defined using Docker Compose. This approach ensures:
- **Reproducibility**: Identical deployments across different environments
- **Version Control**: Infrastructure definition tracked in Git
- **Simplicity**: Single command deployment and management
- **Isolation**: Services run in isolated containers with defined networks

### Service Architecture

The stack consists of the following core services:

#### 1. Nextcloud Application (`app`)
- **Image**: `nextcloud:latest`
- **Purpose**: Main Nextcloud application server
- **Port**: 8080:80 (host:container)
- **Dependencies**: PostgreSQL database, Redis cache
- **Volumes**: Persistent storage for Nextcloud data and configuration

#### 2. PostgreSQL Database (`db`)
- **Image**: `postgres:16-alpine`
- **Purpose**: Primary database for Nextcloud data
- **Volume**: Persistent database storage
- **Configuration**: Database name, user, and credentials via environment variables

#### 3. Redis Cache (`redis`)
- **Image**: `redis:7-alpine`
- **Purpose**: In-memory cache for improved performance
- **Configuration**: Password-protected Redis instance
- **Benefits**: Faster file locking, session management, and caching

### Repository Structure

```
wolkenkuckucksheim/
├── .devcontainer/          # Development container configuration
│   └── devcontainer.json   # Devcontainer settings
├── docker/                 # Docker Compose infrastructure
│   ├── docker-compose.yml  # Service definitions
│   └── .env.example        # Environment variable template
├── AGENTS.md              # This file - Development guidelines
├── README.md              # User-facing documentation
├── LICENSE                # Project license
└── .gitignore            # Git ignore patterns
```

### File Organization Guidelines

**docker/ Directory:**
- Contains all Docker Compose related files
- `docker-compose.yml`: Main service definition file
- `.env.example`: Template for environment variables (committed)
- `.env`: Actual secrets and configuration (NOT committed, in .gitignore)

**Configuration Management:**
- All sensitive data (passwords, secrets) must be in `.env` file
- Never commit actual `.env` file to version control
- Use `.env.example` as a template for required variables
- Document all required environment variables

### Security Considerations

1. **Secrets Management**:
   - All passwords and sensitive data in environment variables
   - Use strong, unique passwords for each service
   - Never hardcode secrets in docker-compose.yml

2. **Network Isolation**:
   - Services communicate through dedicated Docker network
   - Only necessary ports exposed to host

3. **Data Persistence**:
   - Use named volumes for data persistence
   - Regular backup strategy for volumes

4. **Updates**:
   - Pin specific image versions for production
   - Test updates in development environment first

## Development Guidelines

### Making Changes

1. **Use the devcontainer** for all development work
2. **Test with docker** for any container-related changes
3. **Keep configurations minimal** and well-documented
4. **Security first** - this project handles personal data infrastructure

### Working with Docker Compose

When making changes to the infrastructure:

1. **Local Development Setup**:
   ```bash
   # Navigate to docker directory
   cd docker/
   
   # Copy environment template
   cp .env.example .env
   
   # Edit .env with your local configuration
   nano .env
   ```

2. **Starting the Stack**:
   ```bash
   # Start all services
   docker compose up -d
   
   # View logs
   docker compose logs -f
   
   # Check service status
   docker compose ps
   ```

3. **Testing Changes**:
   ```bash
   # Validate compose file syntax
   docker compose config
   
   # Recreate services after changes
   docker compose up -d --force-recreate
   
   # Stop all services
   docker compose down
   ```

4. **Adding New Services**:
   - Add service definition to `docker-compose.yml`
   - Document required environment variables in `.env.example`
   - Update AGENTS.md and README.md with service description
   - Test integration with existing services
   - Verify network connectivity and dependencies

5. **Modifying Existing Services**:
   - Make minimal, focused changes
   - Test changes locally before committing
   - Update documentation if configuration changes
   - Consider backward compatibility

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
