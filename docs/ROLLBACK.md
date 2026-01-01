# Rollback Procedures

## Restore SSH Configuration
```bash
# Find backup
ls -la /etc/ssh/sshd_config.backup-*

# Restore
sudo cp /etc/ssh/sshd_config.backup-YYYYMMDD /etc/ssh/sshd_config

# Restart SSH
sudo systemctl restart sshd
```

## Disable UFW
```bash
sudo ufw disable
```

## Disable Fail2ban
```bash
sudo systemctl stop fail2ban
sudo systemctl disable fail2ban
```

## Full System Restore
```bash
# Find backup directory
ls -la /root/server-hardening-backup-*

# Restore configurations
sudo cp -r /root/server-hardening-backup-TIMESTAMP/ssh/* /etc/ssh/
```
