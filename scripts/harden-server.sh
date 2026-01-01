#!/bin/bash
# Server Hardening - Main Orchestration Script

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Logging
LOG_FILE="/var/log/server-hardening.log"

log() {
    echo -e "${GREEN}[$(date +'%Y-%m-%d %H:%M:%S')]${NC} $1" | tee -a "$LOG_FILE"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOG_FILE"
}

warn() {
    echo -e "${YELLOW}[WARNING]${NC} $1" | tee -a "$LOG_FILE"
}

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   error "This script must be run as root"
   exit 1
fi

# Backup configuration files
backup_configs() {
    log "Creating backup of configuration files..."
    BACKUP_DIR="/root/server-hardening-backup-$(date +%Y%m%d-%H%M%S)"
    mkdir -p "$BACKUP_DIR"
    
    cp -r /etc/ssh "$BACKUP_DIR/" 2>/dev/null || true
    cp /etc/sysctl.conf "$BACKUP_DIR/" 2>/dev/null || true
    
    log "Backup created at: $BACKUP_DIR"
}

# Main execution
main() {
    log "========================================="
    log "Server Hardening Script Started"
    log "========================================="
    
    backup_configs
    
    log "Step 1/5: Hardening SSH..."
    bash "$SCRIPT_DIR/harden-ssh.sh"
    
    log "Step 2/5: Setting up firewall..."
    bash "$SCRIPT_DIR/setup-firewall.sh"
    
    log "Step 3/5: Installing and configuring Fail2ban..."
    bash "$SCRIPT_DIR/setup-fail2ban.sh"
    
    log "Step 4/5: Enabling automatic security updates..."
    bash "$SCRIPT_DIR/enable-auto-updates.sh"
    
    log "Step 5/5: Configuring system audit..."
    log "(Audit configuration skipped - implement in future version)"
    
    log "========================================="
    log "Server Hardening Complete!"
    log "========================================="
    log "Please review the log file: $LOG_FILE"
    log "Backup location: $BACKUP_DIR"
    warn "IMPORTANT: Test SSH connection in new terminal before closing this session!"
}

main "$@"
