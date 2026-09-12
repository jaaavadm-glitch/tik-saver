# 🎵 TikSaver

A fast, lightweight TikTok video downloader built for Termux.
Download TikTok videos **without watermark** using a single command.

## ✨ Features

- 🚀 One-command installation
- 💧 No watermark
- 🎬 Best quality available
- 📱 Optimized for Termux (Android)
- 🎵 Optional audio-only download
- ⚡ Fast and lightweight
- 🕘 Download history log

## 📦 Installation

Open Termux and run:

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/jaaavadm-glitch/tiktok-saver/main/install.sh)"

🚀 Usage

```bash
tiks <tiktok-url>
```

Example:

```bash
tiks https://vt.tiktok.com/ZSxxxxx/
```

The video will be saved to:

```
/storage/emulated/0/Download/TikSaver/
```

Audio only

```bash
tiks -a <tiktok-url>
```

Saves only the audio as MP3.

Help

```bash
tiks -h
```

Version

```bash
tiks -v
```

🗑️ Uninstall

```bash
rm -rf ~/bin/tiks
rm -rf ~/.tiktok-saver
```




