#!/bin/bash
# Install and Configure Fail2ban

set -euo pipefail

log() {
    echo "[FAIL2BAN] $1"
}

# Install fail2ban
if ! command -v fail2ban-client &> /dev/null; then
    log "Installing Fail2ban..."
    apt-get update
    apt-get install -y fail2ban
fi

# Create local configuration
cat > /etc/fail2ban/jail.local << 'F2BEOF'
[DEFAULT]
bantime = 3600
findtime = 600
maxretry = 5
destemail = root@localhost
sendername = Fail2Ban

[sshd]
enabled = true
port = 22
logpath = %(sshd_log)s
backend = %(sshd_backend)s
F2BEOF

# Start and enable service
systemctl enable fail2ban
systemctl restart fail2ban

log "✓ Fail2ban installed and configured"
fail2ban-client status
