# infotecs-sysadm-test

## Installation

```
git clone https://github.com/vsmaxim/infotecs-sysadm-test && sudo cp ./infotecs-sysadm-test/{backup-sql,ipscan,pskiller} /usr/local/bin/
```

For scripts you need nmap installed in your system, in ArchLinux it's done via: 
```
sudo pacman -S nmap
```
For other distros, you may better look into distro-specific documentation.

## Notes

### PostgreSQL backup script

Example of usage: `backup-sql ./path-to-config.config`

Configuration file example:
```
DB_HOST=localhost # Host of database
DB_USER=testuser # User of database
DB_BASE=test # Database name
DB_PASS=PaSsSwoRd1 # Database password
BACKUP_PATH=/path/to/backups/ # Path where backup will be stored
BACKUP_COUNT=10 # Count of backup files to keep
BACKUP_PREFIX=sqlbackup # Prefix to every backup file
```

Crontab example of having script executing on weekdays(excluding sat and sun) at 01:05: `5 1 * * 1-5 /usr/local/bin/backup-sql /etc/backup-sql/backup.config`.

The crontab assumes you have your script at `/usr/local/bin/backup-sql` and configuration file of it at `/etc/backup-sql/backup.config`. 
### IP Scanner script

Example of usage: `ipscaner 192.168.0.0/30`

Regarding to how nmap works, it'll ask you to prompt sudo password, or you can just call it explicitly with sudo using: `sudo ipscanner 192.168.0.0/30`.


### PSKiller script

Example of usage: `pskiller chrome ./passwords.txt localhost 192.168.1.101 192.168.1.102`

password.txt format:
```
Username
Password
UserUsername
UserPassword
```

Where: 
```
Username - ssh username
Password - ssh password
UserUsername - user from which to kill process (if not specified then killing by sudo)
UserUsername - user password
```
