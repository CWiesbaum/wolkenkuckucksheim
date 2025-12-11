# Docker Compose Configuration

This directory contains the Docker Compose configuration for the Nextcloud stack.

## Files

- **`docker-compose.yml`**: Main service definitions for Nextcloud, PostgreSQL, and Redis
- **`.env.example`**: Template for environment variables (copy to `.env` and customize)
- **`.env`**: Your actual configuration with secrets (not committed to Git)

## Quick Start

1. **Create your environment file:**
   ```bash
   cp .env.example .env
   ```

2. **Edit `.env` with your configuration:**
   ```bash
   nano .env
   ```
   
   Set secure passwords for:
   - `POSTGRES_PASSWORD`
   - `REDIS_PASSWORD`
   - `NEXTCLOUD_ADMIN_PASSWORD`

3. **Start the stack:**
   ```bash
   docker compose up -d
   ```

4. **Check status:**
   ```bash
   docker compose ps
   docker compose logs -f
   ```

5. **Access Nextcloud:**
   - URL: http://localhost:8080
   - Username: Value from `NEXTCLOUD_ADMIN_USER`
   - Password: Value from `NEXTCLOUD_ADMIN_PASSWORD`

## Services

### Nextcloud (`app`)
- Main application server
- Exposed on port 8080
- Data stored in `nextcloud_data` volume

### PostgreSQL (`db`)
- Database backend
- Version: PostgreSQL 16 (Alpine)
- Data stored in `db_data` volume

### Redis (`redis`)
- Cache and session storage
- Version: Redis 7 (Alpine)
- Improves performance significantly

## Management Commands

```bash
# Start services
docker compose up -d

# View logs
docker compose logs -f [service_name]

# Restart services
docker compose restart

# Stop services
docker compose stop

# Stop and remove containers
docker compose down

# Stop and remove everything including volumes (DATA LOSS!)
docker compose down -v

# Validate configuration
docker compose config

# Pull latest images
docker compose pull

# Rebuild containers
docker compose up -d --build --force-recreate
```

## Volumes

- **`db_data`**: PostgreSQL database files
- **`nextcloud_data`**: Nextcloud application data, config, and uploaded files

## Network

All services communicate through the `nextcloud_network` bridge network. This provides isolation from other Docker containers and allows services to communicate by service name.

## Security Notes

- Always use strong, unique passwords in `.env`
- Never commit `.env` to version control
- Review and update `NEXTCLOUD_TRUSTED_DOMAINS` for production
- Consider using reverse proxy (nginx, Traefik) for HTTPS in production
- Regular backups of volumes are essential

## Troubleshooting

### Nextcloud won't start
- Check logs: `docker compose logs app`
- Ensure database is ready: `docker compose logs db`
- Verify environment variables in `.env`

### Can't access Nextcloud
- Check if services are running: `docker compose ps`
- Verify port 8080 is not in use: `netstat -an | grep 8080`
- Check trusted domains configuration

### Performance issues
- Ensure Redis is running: `docker compose ps redis`
- Check Redis connection in Nextcloud admin panel
- Monitor resource usage: `docker stats`

## Backup & Restore

### Backup
```bash
# Backup volumes
docker compose stop
docker run --rm -v nextcloud_data:/data -v $(pwd):/backup alpine tar czf /backup/nextcloud-backup.tar.gz /data
docker run --rm -v db_data:/data -v $(pwd):/backup alpine tar czf /backup/db-backup.tar.gz /data
docker compose start
```

### Restore
```bash
# Restore volumes (ensure containers are stopped!)
docker compose stop
docker run --rm -v nextcloud_data:/data -v $(pwd):/backup alpine tar xzf /backup/nextcloud-backup.tar.gz -C /
docker run --rm -v db_data:/data -v $(pwd):/backup alpine tar xzf /backup/db-backup.tar.gz -C /
docker compose start
```

## Production Deployment

For production use, consider:

1. **HTTPS/TLS**: Add reverse proxy (nginx, Traefik) with Let's Encrypt
2. **Version Pinning**: Use specific image tags instead of `:latest`
3. **Resource Limits**: Add CPU/memory limits to services
4. **Monitoring**: Implement health checks and monitoring
5. **Backups**: Automated backup solution
6. **Updates**: Establish update and testing procedures
