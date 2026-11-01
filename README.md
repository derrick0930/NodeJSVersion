# Node.js Docker Images for Pterodactyl

Image Node.js 16 sampai 24 untuk [Pterodactyl](https://pterodactyl.io), lengkap dengan egg yang bisa dipakai langsung. Cocok untuk bot Discord, API, atau aplikasi Node.js lain yang dijalankan lewat Panel.

Image di Docker Hub: [`derrick0930/nodejs`](https://hub.docker.com/r/derrick0930/nodejs)

## Tag

| Tag | Node.js |
|-----|---------|
| `16` `17` `18` `19` | 16 - 19 (EOL, untuk project lama) |
| `20` `21` `22` `23` | 20 - 23 |
| `24`, `latest` | 24 |

Hanya build `linux/amd64`.

## Isi image

- Base `debian:bookworm-slim`, binary Node.js disalin dari image resmi `node`
- `git`, `curl`, `ca-certificates`, `iproute2`, `build-essential`, `python3`
- User `container`, working directory `/home/container`
- Entrypoint yang mengubah `{{VARIABLE}}` pada startup Pterodactyl menjadi nilai variabel egg, lalu menjalankannya

## Pakai di Pterodactyl

1. Admin > Nests > Import Egg, pilih `egg-nodejs-custom.json`
2. Buat server dari egg **Node.js Custom**, pilih versi Node di Docker Image
3. Upload file project, atur `STARTUP_FILE`, lalu Start

### Variabel egg

| Variabel | Default | Fungsi |
|----------|---------|--------|
| `STARTUP_FILE` | `index.js` | File utama yang dijalankan |
| `CUSTOM_STARTUP` | `/usr/local/bin/node /home/container/${STARTUP_FILE} ${NODE_ARGS}` | Perintah terakhir saat start, bisa diganti, mis. `npm start` |
| `NODE_ARGS` | | Argumen tambahan untuk node |
| `AUTO_INSTALL` | `1` | Jalankan `npm install` otomatis jika ada `package.json` |
| `NPM_ARGS` | | Argumen tambahan untuk `npm install`, mis. `--omit=dev` |
| `NODE_PACKAGES` | | Paket npm tambahan yang di-install saat start |
| `UNNODE_PACKAGES` | | Paket npm yang di-uninstall saat start |
| `AUTO_UPDATE` | `0` | `git pull` otomatis jika ada folder `.git` |
| `GIT_ADDRESS`, `BRANCH`, `USERNAME`, `ACCESS_TOKEN` | | Clone repo saat install server (opsional) |

Urutan saat start: `git pull` (opsional), install/uninstall paket, `npm install`, lalu `CUSTOM_STARTUP`.

`CUSTOM_STARTUP` dijalankan dengan `exec`, jadi Node menjadi proses utama dan tombol Stop bekerja normal. Untuk perintah berantai, bungkus dengan `sh -c '...'`.

## Struktur

```
.
├── Dockerfile
├── entrypoint.sh
├── egg-nodejs-custom.json      # satu egg untuk semua versi
└── per-version/                # egg terpisah per versi
```

## Catatan

Node 16, 17, 18, 19, 21, dan 23 sudah tidak mendapat update keamanan. Pakai 20, 22, atau 24 untuk project baru.
