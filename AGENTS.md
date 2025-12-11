# AI Agent Development Guide

This document provides guidance for AI agents working on the Wolkenkuckucksheim project.

## Development Environment

### Devcontainer

This project uses a devcontainer for consistent development environments. The devcontainer configuration is located in `.devcontainer/devcontainer.json`.

**Key features:**
- **Base Image**: Ubuntu 24.04 LTS
- **Primary User**: `vscode` (UID 1000, GID 1000)
- **Shell**: Zsh with Oh My Zsh installed
- **GitHub Codespaces**: Fully compatible and tested

**Setup:**
1. Open the project in VS Code with the Dev Containers extension
2. VS Code will prompt to reopen in container
3. Alternatively, use "Reopen in Container" from the command palette
4. For GitHub Codespaces, simply create a new codespace from the repository

### Container Runtime: Podman

This project uses **Podman** as the container runtime instead of Docker.

**Important Configuration:**
- Podman is installed via the devcontainer features
- Storage driver is configured to use **vfs** instead of overlayfs
- VFS is required because overlayfs doesn't work properly in devcontainer/rootless environments
- Configuration is applied automatically via `setup-podman-vfs.sh` post-create script

**Podman Configuration Files:**
- `~/.config/containers/storage.conf` - Storage driver configuration (vfs)
- `~/.config/containers/containers.conf` - Additional podman settings

**Usage:**
```bash
# Podman commands work similarly to Docker
podman version
podman info
podman run hello-world
podman build -t myimage .
podman ps
```

**Key Differences from Docker:**
- Rootless by default (runs as non-root user)
- No daemon required (podman is daemonless)
- Compatible with Docker CLI commands
- Can run as `podman` or with `alias docker=podman`

## Project Overview

Wolkenkuckucksheim is an Infrastructure-as-Code (IaC) project for automating the setup of a private Nextcloud instance. The goal is reproducible, secure deployment on a personal server with data sovereignty in mind.

## Development Guidelines

### Making Changes

1. **Use the devcontainer** for all development work
2. **Test with podman** for any container-related changes
3. **Keep configurations minimal** and well-documented
4. **Security first** - this project handles personal data infrastructure

### Testing Container Builds

When working with container images or builds:
```bash
# Always use podman in the devcontainer
podman build -t test-image .
podman run --rm test-image
```

### File Organization

- Infrastructure code and configurations should be well-organized
- Use clear naming conventions
- Document any non-obvious configurations
- Keep secrets out of version control

## Troubleshooting

### Podman Storage Issues

If you encounter storage driver errors:
```bash
# Check current configuration
podman info | grep -i storage

# Verify vfs is configured
cat ~/.config/containers/storage.conf

# Reset podman storage (warning: removes all images/containers)
podman system reset
```

### Devcontainer Issues

If the devcontainer fails to build:
1. Check `.devcontainer/devcontainer.json` syntax
2. Review post-create script logs
3. Rebuild container from scratch (Command Palette > "Rebuild Container")

## Resources

- [Podman Documentation](https://docs.podman.io/)
- [Dev Containers Documentation](https://containers.dev/)
- [GitHub Codespaces Documentation](https://docs.github.com/en/codespaces)
