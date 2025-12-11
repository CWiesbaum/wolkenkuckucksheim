#!/bin/bash
set -e

echo "Configuring podman to use vfs storage driver for devcontainer..."

# Create containers directory structure for the user
mkdir -p ~/.config/containers

# Create storage.conf with vfs driver
# VFS is required because overlayfs doesn't work in devcontainer/rootless environments
cat > ~/.config/containers/storage.conf << 'EOF'
[storage]
driver = "vfs"

[storage.options]
# VFS storage driver options
EOF

# Create containers.conf for additional podman configuration
cat > ~/.config/containers/containers.conf << 'EOF'
[engine]
# Use vfs storage driver
events_logger = "file"

[network]
# Network configuration for rootless podman
EOF

echo "Podman configuration completed successfully!"
echo "Storage driver set to: vfs"

# Verify podman installation and configuration
if command -v podman &> /dev/null; then
    echo "Podman version:"
    podman --version
    echo "Storage driver:"
    podman info --format '{{.Store.GraphDriverName}}' || echo "Could not retrieve storage driver"
else
    echo "Warning: podman command not found"
fi
