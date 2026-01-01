#!/bin/bash
# Setup UFW Firewall

set -euo pipefail

log() {
    echo "[FIREWALL] $1"
}

# Install UFW if not present
if ! command -v ufw &> /dev/null; then
    log "Installing UFW..."
    apt-get update
    apt-get install -y ufw
fi

# Reset UFW to defaults
log "Resetting UFW to defaults..."
ufw --force reset

# Default policies
ufw default deny incoming
ufw default allow outgoing

# Allow SSH (CRITICAL - don't lock yourself out!)
SSH_PORT=$(grep "^Port" /etc/ssh/sshd_config | awk '{print $2}' || echo "22")
ufw allow "$SSH_PORT"/tcp comment 'SSH'
log "✓ Allowed SSH on port $SSH_PORT"

# Allow HTTP/HTTPS (common for web servers)
ufw allow 80/tcp comment 'HTTP'
ufw allow 443/tcp comment 'HTTPS'
log "✓ Allowed HTTP/HTTPS"

# Enable UFW
ufw --force enable

# Show status
ufw status verbose

log "Firewall setup complete"
