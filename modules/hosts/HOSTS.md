# Host roles

## server01 (Media-centric) 

The primary media server that handles the full *arr stack + Any media (personal).

| Category | Services |
|---|---|
| **"Cloud" storage** | Radicale |
| **Media** | Nixflix |
| **File serving** | Copyparty |
| **Reverse proxy** | Caddy, Cloudflare Tunnels (immich) |
| **Backup** | Restic (weekly to remote, immich) |
| **Sync** | Syncthing |
| **Photo** | Immich |
| **Notifications** | Ntfy |

**Data mounts:** `/data/media`, `/data/downloads`, networked to server02.

## server02 (Storage/Development centric)

Lightweight server focused on storage (ZFS) and dev tools.

| Category | Services |
|---|---|
| **Development** | OpenVSCode Server (gcc, rust, clang toolchains), Hydra, Attic cache |
| **Reverse proxy** | Caddy |
| **Monitoring** | Beszel (Hosted interface) |
| **Storage** | ZFS datasets |

**Data mounts:** ZFS pool (external), `/data` overlay onto `/export/server02`
