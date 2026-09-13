#!/data/data/com.termux/files/usr/bin/bash

# ═══════════════════════════════════════════════════
#  ⚡ TikSaver Auto Installer v3.0
#  github.com/jaaavadm-glitch/tik-saver
# ═══════════════════════════════════════════════════

REPO="jaaavadm-glitch/tik-saver"
BRANCH="main"
VERSION="3.0.0"

# Colors
RED='\033[1;31m'
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;34m'
MAGENTA='\033[1;35m'
CYAN='\033[1;36m'
WHITE='\033[1;37m'
GRAY='\033[0;90m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m'

# ═══════════════════════════════════════════════════
#  Animated Banner
# ═══════════════════════════════════════════════════
animate_banner() {
    clear
    local logo=(
        "  ████████╗██╗██╗  ██╗███████╗ █████╗ ██╗   ██╗███████╗██████╗ "
        "  ╚══██╔══╝██║██║ ██╔╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗"
        "     ██║   ██║█████╔╝ ███████╗███████║██║   ██║█████╗  ██████╔╝"
        "     ██║   ██║██╔═██╗ ╚════██║██╔══██║╚██╗ ██╔╝██╔══╝  ██╔══██╗"
        "     ██║   ██║██║  ██╗███████║██║  ██║ ╚████╔╝ ███████╗██║  ██║"
        "     ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝"
    )
    
    local colors=("$MAGENTA" "$MAGENTA" "$CYAN" "$CYAN" "$BLUE" "$BLUE")
    
    echo ""
    for i in "${!logo[@]}"; do
        echo -e "${colors[$i]}${logo[$i]}${NC}"
        sleep 0.06
    done
    echo ""
    sleep 0.2
    echo -e "${GREEN}              ⚡ Fast  •  🆓 Free  •  💧 No Watermark${NC}"
    echo -e "${GRAY}                       v${VERSION}  •  TikWM API${NC}"
    echo ""
    echo -e "${MAGENTA}  ══════════════════════════════════════════════════${NC}"
    echo ""
    sleep 0.3
}

# ═══════════════════════════════════════════════════
#  Spinner
# ═══════════════════════════════════════════════════
spinner() {
    local pid=$1
    local text=$2
    local frames=("◐" "◓" "◑" "◒")
    local colors=("$CYAN" "$MAGENTA" "$BLUE" "$GREEN")
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        local c=${colors[$((i % 4))]}
        printf "\r        ${c}${frames[$((i % 4))]}${NC} ${DIM}${text}${NC}   "
        i=$((i + 1))
        sleep 0.1
    done
    printf "\r\033[K"
}

# ═══════════════════════════════════════════════════
#  Step Header
# ═══════════════════════════════════════════════════
step() {
    echo ""
    echo -e "  ${MAGENTA}▸${NC} ${BOLD}${WHITE}$1${NC}  ${GRAY}$2${NC}"
    echo -e "  ${GRAY}─────────────────────────────────────${NC}"
}

done_step() {
    echo -e "        ${GREEN}✓${NC} ${DIM}$1${NC}"
}

# ═══════════════════════════════════════════════════
#  MAIN
# ═══════════════════════════════════════════════════

animate_banner

# ─── [1/5] Dependencies ───
step "[1/5]" "Installing dependencies"
(
    pkg install -y curl jq > /dev/null 2>&1
) &
spinner $! "Installing curl, jq..."
done_step "curl, jq installed"

# ─── [2/5] Storage ───
step "[2/5]" "Setting up storage"
(
    if [ ! -d "/storage/emulated/0" ]; then
        termux-setup-storage > /dev/null 2>&1 || true
    fi
    mkdir -p /storage/emulated/0/Download/TikSaver 2>/dev/null || true
) &
spinner $! "Configuring storage access..."
done_step "Storage ready"

# ─── [3/5] Download tiks ───
step "[3/5]" "Fetching TikSaver core"
(
    mkdir -p ~/bin
    curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/bin/tiks" -o ~/bin/tiks
    chmod +x ~/bin/tiks
) &
spinner $! "Downloading tiks binary..."
done_step "tiks downloaded"

# ═══════════════════════════════════════════════════
#  🎯 KEY PART: Install to $PREFIX/bin (always in PATH)
# ═══════════════════════════════════════════════════
step "[4/5]" "Installing command (permanent)"

# مسیر اصلی Termux که همیشه تو PATH هست
PREFIX_BIN="$PREFIX/bin"

# کپی tiks به $PREFIX/bin (همیشه در PATH)
cp ~/bin/tiks "$PREFIX_BIN/tiks"
chmod +x "$PREFIX_BIN/tiks"

# اطمینان از وجود $HOME/bin در PATH
if ! grep -q 'export PATH=$PATH:$HOME/bin' ~/.bashrc 2>/dev/null; then
    echo '' >> ~/.bashrc
    echo '# ═══ TikSaver PATH ═══' >> ~/.bashrc
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
fi

# Export برای همین سشن
export PATH=$PATH:$HOME/bin

done_step "tiks installed to \$PREFIX/bin/tiks"

# ─── [5/5] Verify ───
step "[5/5]" "Verifying installation"

# چک کن فایل هست
if [ -f "$PREFIX_BIN/tiks" ] && [ -x "$PREFIX_BIN/tiks" ]; then
    done_step "tiks is ready"
    INSTALL_OK=true
elif [ -f ~/bin/tiks ] && [ -x ~/bin/tiks ]; then
    done_step "tiks is ready (in ~/bin)"
    INSTALL_OK=true
else
    echo -e "        ${RED}✗${NC} ${WHITE}Installation failed${NC}"
    INSTALL_OK=false
fi

# ─── Final Animation ───
echo ""
if [ "$INSTALL_OK" = true ]; then
    for i in 1 2 3; do
        printf "\r  ${GREEN}◐${NC} ${DIM}Finalizing...${NC}   "
        sleep 0.1
        printf "\r  ${GREEN}◓${NC} ${DIM}Finalizing...${NC}   "
        sleep 0.1
        printf "\r  ${GREEN}◑${NC} ${DIM}Finalizing...${NC}   "
        sleep 0.1
        printf "\r  ${GREEN}◒${NC} ${DIM}Finalizing...${NC}   "
        sleep 0.1
    done
    printf "\r\033[K"
    
    echo -e "${GREEN}  ╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}  ║${NC}                                                  ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}      ${BOLD}${WHITE}🎉  INSTALLATION COMPLETE!${NC}                    ${GREEN}║${NC}"
    echo -e "${GREEN}  ║${NC}                                                  ${GREEN}║${NC}"
    echo -e "${GREEN}  ╚══════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${YELLOW}⚡${NC} ${BOLD}${WHITE}Quick Start${NC}"
    echo -e "  ${GRAY}─────────────────────────────────────${NC}"
    echo ""
    echo -e "  ${CYAN}1.${NC} ${WHITE}Download a video:${NC}"
    echo -e "     ${DIM}\$${NC} ${CYAN}tiks${NC} ${GRAY}\"https://vt.tiktok.com/ZSxxxxx/\"${NC}"
    echo ""
    echo -e "  ${CYAN}2.${NC} ${WHITE}Show help:${NC}"
    echo -e "     ${DIM}\$${NC} ${CYAN}tiks -h${NC}"
    echo ""
    echo -e "  ${CYAN}3.${NC} ${WHITE}Show version:${NC}"
    echo -e "     ${DIM}\$${NC} ${CYAN}tiks -v${NC}"
    echo ""
    echo -e "  ${GRAY}📁 Videos save to:${NC}"
    echo -e "     ${DIM}/storage/emulated/0/Download/TikSaver/${NC}"
    echo ""
    echo -e "  ${GREEN}✨ tiks is ready to use — no restart needed!${NC}"
    echo ""
    echo -e "  ${MAGENTA}🔗${NC} ${DIM}github.com/${REPO}${NC}"
    echo ""
    echo -e "  ${GREEN}Thanks for installing TikSaver! 💚${NC}"
    echo ""
    
    # تست خودکار
    echo -e "  ${CYAN}→${NC} ${DIM}Testing installation...${NC}"
    sleep 0.5
    if command -v tiks &> /dev/null; then
        echo -e "  ${GREEN}✓${NC} ${WHITE}tiks is in PATH${NC}"
    else
        echo -e "  ${YELLOW}⚠${NC} ${WHITE}Run: source ~/.bashrc${NC}"
    fi
    echo ""
else
    echo -e "${RED}  ╔══════════════════════════════════════════════════╗${NC}"
    echo -e "${RED}  ║${NC}      ${BOLD}${WHITE}✗  Installation Failed${NC}                       ${RED}║${NC}"
    echo -e "${RED}  ╚══════════════════════════════════════════════════╝${NC}"
    echo ""
    echo -e "  ${YELLOW}Try manually:${NC}"
    echo -e "  ${DIM}\$${NC} ${CYAN}curl -fsSL https://raw.githubusercontent.com/${REPO}/${BRANCH}/bin/tiks -o \$PREFIX/bin/tiks${NC}"
    echo -e "  ${DIM}\$${NC} ${CYAN}chmod +x \$PREFIX/bin/tiks${NC}"
    echo ""
    exit 1
fi
