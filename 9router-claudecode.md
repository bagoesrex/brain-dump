# Claude Code + 9Router - Quick Reference

## Setup

| Variable | Value |
|----------|-------|
| `ANTHROPIC_BASE_URL` | `http://localhost:20128/v1` |
| `ANTHROPIC_API_KEY` | `` |
| `ANTHROPIC_MODEL` | `oc/muse-spark-1.3-contributor-free(xhigh)` (default) |

---

## Shortcut Jalankan Claude per Model

### OpenCode (Free, No Auth)

```powershell
# Muse Spark 1.3 - thinking xhigh (default)
claude --model "oc/muse-spark-1.3-contributor-free(xhigh)"

# Muse Spark 1.3 - thinking high
claude --model "oc/muse-spark-1.3-contributor-free(high)"

# Muse Spark 1.3 - thinking medium
claude --model "oc/muse-spark-1.3-contributor-free(medium)"

# Muse Spark 1.3 - thinking low
claude --model "oc/muse-spark-1.3-contributor-free(low)"

# Muse Spark 1.3 - thinking minimal
claude --model "oc/muse-spark-1.3-contributor-free(minimal)"
```

### Antigravity (Claude)

```powershell
# Claude Sonnet 4.6 (1M context)
claude --model ag/claude-sonnet-4-6 --dangerously-skip-permissions

# Claude Opus 4.6 dengan thinking
claude --model ag/claude-opus-4-6-thinking
```

### Antigravity (Gemini)

```powershell
# Gemini 3.8 Flash - thinking high
claude --model ag/gemini-3.8-flash-high

# Gemini 3.8 Flash - thinking medium
claude --model ag/gemini-3.8-flash-medium

# Gemini 3.8 Flash - thinking low
claude --model ag/gemini-3.8-flash-low

# Gemini 3.8 Flash (default)
claude --model ag/gemini-3.8-flash

# Gemini 3.7 Flash - thinking high
claude --model ag/gemini-3.7-flash-high

# Gemini Pro Agent
claude --model ag/gemini-pro-agent
```

### Antigravity (GPT)

```powershell
# GPT OSS 120B
claude --model ag/gpt-oss-120b-medium
```

---

## Ganti Default Model

```powershell
# Set model default permanen
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_MODEL", "ag/claude-sonnet-4-6", "User")

# Kembalikan ke muse-spark
[System.Environment]::SetEnvironmentVariable("ANTHROPIC_MODEL", "oc/muse-spark-1.3-contributor-free(xhigh)", "User")
```

> Setelah ganti default, buka terminal baru agar perubahan aktif.

---

## Thinking Effort Levels (oc/ models)

| Suffix | Kecepatan | Kualitas |
|--------|-----------|----------|
| `(minimal)` | Tercepat | Dasar |
| `(low)` | Cepat | Rendah |
| `(medium)` | Sedang | Sedang |
| `(high)` | Lambat | Tinggi |
| `(xhigh)` | Paling lambat | Terbaik |

---

## Catatan

- 9Router harus berjalan di `http://localhost:20128` sebelum menjalankan `claude`
- Model `oc/` memerlukan suffix thinking effort agar berfungsi, contoh: `(xhigh)`
- Untuk melihat semua model tersedia: buka `http://localhost:20128` di browser
