# Linux / VPS - Cheat Sheet

## 1. Direktori Penting Linux

| Path | Fungsi & Penjelasan Singkat |
| ---- | --------------------------- |
| `/` | Root direktori, induk dari seluruh filesystem. |
| `/root` | Home direktori khusus user `root` (super user). |
| `/home/<user>` | Home direktori untuk user non-root (tempat paling aman buat file/bot proyek). |
| `/etc` | Konfigurasi sistem & aplikasi (misal: `/etc/systemd/system/`, `/etc/nginx/`). |
| `/var` | Data dinamis yang sering berubah (database, spool, cache). |
| `/var/log` | File log sistem & aplikasi (cek saat aplikasi crash). |
| `/opt` | Tempat instalasi aplikasi pihak ketiga (sering dipakai deploy bot standalone). |
| `/tmp` | File sementara, otomatis dihapus saat sistem reboot atau berkala. |
| `/bin` / `/usr/bin` | Binary file atau executable command sistem (`ls`, `curl`, `python3`, `node`). |

---

## 2. Navigasi & File Dasar

```bash
# Navigasi & Direktori
pwd                       # Cek direktori aktif saat ini
ls -la                    # List file lengkap (termasuk file hidden berawalan .)
cd /path/ke/folder        # Pindah folder
mkdir -p proyek/bot       # Buat folder (termasuk sub-folder)
rm -rf folder_sampah      # Hapus folder beserta isinya secara paksa (HATI-HATI)
cp -r asal/ tujuan/       # Copy folder dan isinya
mv nama_lama nama_baru    # Rename atau pindah file/folder

# Edit & Baca File
nano config.env           # Text editor mudah di terminal
cat file.txt              # Print seluruh isi file ke terminal
tail -f file.log          # Pantau isi log secara real-time
grep -rn "ERROR" /path/   # Cari teks "ERROR" di semua file dalam folder
```

---

## 3. Monitoring Resource & Proses

```bash
# RAM & Disk
free -h                   # Cek sisa RAM & Swap (format human-readable: GB/MB)
df -h                     # Cek sisa kapasitas storage/disk
du -sh *                  # Cek ukuran tiap file/folder di direktori saat ini

# CPU & Proses
htop                      # Monitoring interaktif (RAM, CPU, task). Install: apt install htop
top                       # Monitoring bawaan tanpa install
ps aux | grep node        # Cari proses spesifik yang sedang berjalan
kill -9 <PID>             # Matikan paksa proses berdasarkan PID
pkill -f nama_script.py   # Matikan proses berdasarkan nama file/perintah
```

---

## 4. Menjalankan Bot 24/7 (Systemd / Systemctl)

Systemd adalah cara standar dan paling stabil untuk menjalankan bot: otomatis restart jika crash dan otomatis nyala saat server reboot.

### Langkah 1: Buat Unit File Service
Buat file baru di `/etc/systemd/system/<nama-bot>.service`:

```bash
sudo nano /etc/systemd/system/mybot.service
```

### Langkah 2: Isi Konfigurasi Service

**Template untuk Bot Python:**
```ini
[Unit]
Description=My Telegram/Discord Bot Service
After=network.target

[Service]
Type=simple
User=root
# Ganti path folder proyek dan path virtual environment / python
WorkingDirectory=/home/ubuntu/mybot
ExecStart=/home/ubuntu/mybot/venv/bin/python main.py
Restart=always
RestartSec=5
# Opsional: file env
EnvironmentFile=/home/ubuntu/mybot/.env

[Install]
WantedBy=multi-user.target
```

**Template untuk Bot NodeJS:**
```ini
[Unit]
Description=My NodeJS Bot Service
After=network.target

[Service]
Type=simple
User=root
WorkingDirectory=/home/ubuntu/mybot
ExecStart=/usr/bin/node index.js
Restart=always
RestartSec=5
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
```

> **Tips:** Gunakan command `which python3` atau `which node` untuk memastikan letak binary path.

### Langkah 3: Perintah Kontrol Service (`systemctl`)

| Perintah | Fungsi |
| -------- | ------ |
| `sudo systemctl daemon-reload` | Reload konfigurasi setelah edit/buat file `.service` |
| `sudo systemctl enable mybot` | Pasang bot agar otomatis nyala saat VPS reboot |
| `sudo systemctl start mybot` | Jalankan bot |
| `sudo systemctl stop mybot` | Hentikan bot |
| `sudo systemctl restart mybot` | Restart bot |
| `sudo systemctl status mybot` | Cek apakah bot sedang aktif (running) atau error |
| `sudo systemctl disable mybot` | Nonaktifkan auto-start saat reboot |

---

## 5. Cek Log Service (`journalctl`)

```bash
# Pantau log bot secara live (mirip streaming console log)
sudo journalctl -u mybot -f

# Tampilkan 50 baris terakhir log
sudo journalctl -u mybot -n 50 --no-pager

# Tampilkan log hari ini saja
sudo journalctl -u mybot --since today

# Tampilkan log 1 jam terakhir
sudo journalctl -u mybot --since "1 hour ago"

# Bersihkan log systemd jika disk penuh (sisakan 100MB)
sudo journalctl --vacuum-size=100M
```

---

## 6. Alternatif Cepat Background Runner

Jika butuh testing sementara tanpa setup systemd:

### Menggunakan `tmux` (Terminal Multiplexer)
```bash
tmux new -s bot_session   # Buat session terminal baru
# Jalankan bot di sini, lalu tekan CTRL + B, lalu tekan D untuk detach (keluar tanpa mematikan)
tmux attach -t bot_session # Masuk kembali ke session bot
tmux ls                    # List session aktif
tmux kill-session -t bot_session # Hapus/tutup session
```

### Menggunakan `screen`
```bash
screen -S bot_session     # Buat session
# Tekan CTRL + A, lalu tekan D untuk detach
screen -r bot_session     # Masuk kembali
```

---

## 7. Port, Jaringan & Firewall (UFW)

```bash
# Cek Port Aktif
ss -tulpn                 # List semua port yang sedang listening
lsof -i :3000             # Cek aplikasi apa yang menggunakan port 3000

# Firewall Ubuntu/Debian (UFW)
sudo ufw status           # Cek status firewall
sudo ufw allow 22/tcp     # PENTING: Buka port SSH sebelum aktifkan UFW agar tidak terkunci!
sudo ufw allow 80/tcp     # Buka HTTP
sudo ufw allow 443/tcp    # Buka HTTPS
sudo ufw allow 3000/tcp   # Buka port custom bot/webhook
sudo ufw delete allow 3000/tcp # Hapus rule port
sudo ufw enable           # Aktifkan firewall
```

---

## 8. Tips Tambahan untuk Bot di VPS

### Setup Swap Memory (Penting untuk VPS RAM 1GB / 512MB)
Mencegah bot mati mendadak karena Out of Memory (OOM Killer):
```bash
sudo fallocate -l 2G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
```

### Set Timezone Server ke WIB
```bash
sudo timedatectl set-timezone Asia/Jakarta
timedatectl               # Cek waktu aktif sistem
```

### Hak Akses File (`chmod` & `chown`)
```bash
chmod +x start.sh         # Buat script jadi executable
chown -R ubuntu:ubuntu /home/ubuntu/mybot  # Ganti kepemilikan folder ke user spesifik
```
