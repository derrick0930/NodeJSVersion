# Pterodactyl Node.js (16-24)

Isi:
- `egg-nodejs-custom.json` : satu egg, versi dipilih dari Docker Image di tab Startup
- `per-version/` : egg terpisah per versi
- `Dockerfile`, `entrypoint.sh` : image Node 16-24 untuk Pterodactyl
- `build-push.ps1` : build + push ke Docker Hub (PowerShell)
- `.github/workflows/docker.yml` : build + push otomatis via GitHub Actions

Image egg: `shardox/nodejs:<versi>`. Ganti `shardox` di egg dan di script kalau username Docker Hub beda.
Mau langsung jalan tanpa build sendiri: ganti `docker_images` ke `ghcr.io/parkervcp/yolks:nodejs_<versi>`.

Build + push (Windows, Docker Desktop jalan):
    docker login
    powershell -ExecutionPolicy Bypass -File .\build-push.ps1 -User shardox

Repo Docker Hub harus Public. Lalu import egg di Panel: Admin > Nests > Import Egg.

Variabel egg: STARTUP_FILE, CUSTOM_STARTUP, NODE_ARGS, AUTO_INSTALL, NPM_ARGS, NODE_PACKAGES, UNNODE_PACKAGES, AUTO_UPDATE, GIT_*.
Urutan start: git pull (opsional) > install/uninstall paket > npm install > CUSTOM_STARTUP.
