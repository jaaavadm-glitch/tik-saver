#!/data/data/com.termux/files/usr/bin/bash

set -e

GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

REPO="jaaavadm-glitch/tik-saver"
BRANCH="main"

echo -e "${CYAN}"
echo "  _____ _ _    _____                  "
echo " |_   _(_) | _/ ____|_ ___ _   _____ _ "
echo "   | | | | |/ / (___| |/ _ \\ \\ / / _ \\ |"
echo "   | | | |   < \\___ \\ |  __/\\ V /  __/ |"
echo "   |_| |_|_|\\_\\_____/_|\\___| \\_/ \\___|_|"
echo -e "${NC}"
echo -e "${GREEN}>> Installing TikSaver by jaaavadm-glitch...${NC}"
echo ""

echo -e "${YELLOW}[1/5]${NC} Updating packages..."
pkg update -y > /dev/null 2>&1 || true
pkg upgrade -y > /dev/null 2>&1 || true

echo -e "${YELLOW}[2/5]${NC} Installing dependencies..."
pkg install -y python ffmpeg curl > /dev/null 2>&1

echo -e "${YELLOW}[3/5]${NC} Setting up core engine..."
pip install --quiet --upgrade yt-dlp > /dev/null 2>&1

echo -e "${YELLOW}[4/5]${NC} Configuring storage..."
termux-setup-storage
sleep 2

echo -e "${YELLOW}[5/5]${NC} Installing command..."
mkdir -p ~/bin
mkdir -p ~/.tiktok-saver

curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/bin/tiks" \
    -o ~/bin/tiks
chmod +x ~/bin/tiks

if ! grep -q 'export PATH=$PATH:$HOME/bin' ~/.bashrc 2>/dev/null; then
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
fi

source ~/.bashrc 2>/dev/null || true

echo ""
echo -e "${GREEN}✅ TikSaver installed successfully!${NC}"
echo ""
echo -e "Run: ${CYAN}tiks <tiktok-url>${NC}"
echo -e "Help: ${CYAN}tiks -h${NC}"
echo ""
