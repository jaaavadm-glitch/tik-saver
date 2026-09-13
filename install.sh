#!/data/data/com.termux/files/usr/bin/bash

# ═══════════════════════════════════════════════════════════════
#   ⚡  T I K S A V E R  —  Ultimate Installer  ⚡
#   github.com/jaaavadm-glitch/tik-saver
# ═══════════════════════════════════════════════════════════════

REPO="jaaavadm-glitch/tik-saver"
BRANCH="main"
VERSION="3.0.0"

# ─────────────────────────────────────────────────────────────
#  ANSI Colors
# ─────────────────────────────────────────────────────────────
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
B='\033[1;34m'
M='\033[1;35m'
C='\033[1;36m'
W='\033[1;37m'
GR='\033[0;90m'
BL='\033[5m'
BD='\033[1m'
DM='\033[2m'
NC='\033[0m'

# ─────────────────────────────────────────────────────────────
#  TYPEWRITER — حروف یکی یکی نوشته می‌شن
# ─────────────────────────────────────────────────────────────
typewriter() {
    local text="$1"
    local color="${2:-$W}"
    local delay="${3:-0.02}"
    echo -ne "${color}"
    for ((i=0; i<${#text}; i++)); do
        echo -ne "${text:$i:1}"
        sleep "$delay"
    done
    echo -e "${NC}"
}

# ─────────────────────────────────────────────────────────────
#  PULSE — افکت ضربان
# ─────────────────────────────────────────────────────────────
pulse() {
    local text="$1"
    local color="${2:-$G}"
    for i in 1 2 3; do
        echo -ne "\r  ${color}${BD}${text}${NC}   "
        sleep 0.15
        echo -ne "\r  ${DM}${text}${NC}   "
        sleep 0.15
    done
    echo -ne "\r  ${color}${BD}✓${NC} ${DM}${text}${NC}\n"
}

# ─────────────────────────────────────────────────────────────
#  SPINNER — چرخنده با رنگ‌های چرخشی
# ─────────────────────────────────────────────────────────────
spinner() {
    local pid=$1
    local text="$2"
    local frames=("◐" "◓" "◑" "◒")
    local colors=("$C" "$M" "$B" "$G" "$C")
    local i=0
    while kill -0 "$pid" 2>/dev/null; do
        local c=${colors[$((i % 5))]}
        printf "\r        ${c}${frames[$((i % 4))]}${NC} ${DM}${text}${NC}     "
        i=$((i + 1))
        sleep 0.08
    done
    printf "\r\033[K"
}

# ─────────────────────────────────────────────────────────────
#  PROGRESS BAR — نوار پیشرفت واقعی
# ─────────────────────────────────────────────────────────────
progress_bar() {
    local duration="$1"
    local label="$2"
    local width=36
    local steps=$((duration * 25))
    for ((i=0; i<=steps; i++)); do
        local pct=$((i * 100 / steps))
        local fill=$((i * width / steps))
        local empty=$((width - fill))
        local bar=""
        for ((j=0; j<fill; j++)); do bar+="━"; done
        for ((j=0; j<empty; j++)); do bar+="─"; done
        local c=$([ $pct -lt 34 ] && echo "$C" || ([ $pct -lt 67 ] && echo "$M" || echo "$G"))
        printf "\r        ${c}${bar}${NC} ${W}${pct}%%${NC} ${DM}${label}${NC}"
        sleep 0.04
    done
    printf "\r\033[K"
}

# ─────────────────────────────────────────────────────────────
#  WAVE ANIMATION — موج متحرک
# ─────────────────────────────────────────────────────────────
wave() {
    local text="$1"
    local colors=("$C" "$M" "$B" "$G" "$Y")
    for ((r=0; r<3; r++)); do
        for ((i=0; i<5; i++)); do
            local c=${colors[$i]}
            printf "\r  ${c}${BD}${text}${NC} "
            sleep 0.06
        done
    done
    echo -e "\r  ${G}${BD}${text}${NC} ✓${NC}"
}

# ─────────────────────────────────────────────────────────────
#  STARS — ذرات متحرک
# ─────────────────────────────────────────────────────────────
stars() {
    local chars=("✦" "✧" "·" "˚" "✫" "✬" "✭")
    local colors=("$C" "$M" "$B" "$G" "$Y" "$W")
    for i in {1..12}; do
        local r=$((RANDOM % 40 + 10))
        local c=${colors[$((RANDOM % 6))]}
        local ch=${chars[$((RANDOM % 7))]}
        printf "\033[%dG${c}${ch}${NC}" "$r"
        sleep 0.04
    done
    printf "\r\033[K"
}

# ─────────────────────────────────────────────────────────────
#  STEP HEADER — عنوان مرحله
# ─────────────────────────────────────────────────────────────
step() {
    echo ""
    echo -e "  ${M}╭─────────────────────────────────────────────╮${NC}"
    echo -e "  ${M}│${NC}  ${C}▸${NC} ${BD}${W}$1${NC}  ${DM}$2${NC}"
    echo -e "  ${M}╰─────────────────────────────────────────────╯${NC}"
}

# ─────────────────────────────────────────────────────────────
#  ANIMATED BANNER
# ─────────────────────────────────────────────────────────────
animate_banner() {
    clear
    
    # نصب پیش‌نیاز بنر
    if ! command -v figlet &> /dev/null || ! command -v lolcat &> /dev/null; then
        pkg install -y figlet lolcat > /dev/null 2>&1
    fi
    
    echo ""
    sleep 0.1
    
    # ستاره‌های اولیه
    stars
    sleep 0.2
    
    # بنر رنگی
    if command -v figlet &> /dev/null && command -v lolcat &> /dev/null; then
        figlet -f big "TikSaver" | lolcat -f -p 0.3 -S 40 2>/dev/null || figlet -f big "TikSaver" | lolcat
    else
        echo -e "${M}"
        cat << 'EOF'
   ████████╗██╗██╗  ██╗███████╗ █████╗ ██╗   ██╗███████╗██████╗
   ╚══██╔══╝██║██║ ██╔╝██╔════╝██╔══██╗██║   ██║██╔════╝██╔══██╗
      ██║   ██║█████╔╝ ███████╗███████║██║   ██║█████╗  ██████╔╝
      ██║   ██║██╔═██╗ ╚════██║██╔══██║╚██╗ ██╔╝██╔══╝  ██╔══██╗
      ██║   ██║██║  ██╗███████║██║  ██║ ╚████╔╝ ███████╗██║  ██║
      ╚═╝   ╚═╝╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝  ╚═══╝  ╚══════╝╚═╝  ╚═╝
EOF
        echo -e "${NC}"
    fi
    
    echo ""
    sleep 0.1
    
    # شعار
    typewriter "              ⚡ Fast  ·  🆓 Free  ·  💧 No Watermark" "$G" 0.015
    sleep 0.1
    typewriter "                    v${VERSION}  ·  High-Speed Engine" "$GR" 0.015
    
    echo ""
    sleep 0.1
    echo -e "${M}  ══════════════════════════════════════════════════${NC}"
    echo ""
    sleep 0.2
    
    # ذرات پایانی
    stars
    sleep 0.1
}

# ═══════════════════════════════════════════════════════════════
#  MAIN
# ═══════════════════════════════════════════════════════════════

animate_banner

# ─── [1/5] Dependencies ───
step "[1/5]" "Installing dependencies"
(
    pkg install -y curl jq > /dev/null 2>&1
) &
spinner $! "Installing packages...  curl · jq"
echo -e "        ${G}✓${NC} ${DM}Dependencies ready${NC}"

# ─── [2/5] Storage ───
step "[2/5]" "Setting up storage"
(
    if [ ! -d "/storage/emulated/0" ]; then
        termux-setup-storage > /dev/null 2>&1 || true
    fi
    mkdir -p /storage/emulated/0/Download/TikSaver 2>/dev/null || true
) &
spinner $! "Configuring storage access..."
echo -e "        ${G}✓${NC} ${DM}Storage ready${NC}"

# ─── [3/5] Download core ───
step "[3/5]" "Fetching TikSaver core"
(
    mkdir -p ~/bin
    curl -fsSL "https://raw.githubusercontent.com/${REPO}/${BRANCH}/bin/tiks" -o ~/bin/tiks
    chmod +x ~/bin/tiks
) &
spinner $! "Downloading tiks binary..."
echo -e "        ${G}✓${NC} ${DM}tiks downloaded${NC}"

# ─── [4/5] Install to PREFIX ───
step "[4/5]" "Installing command (permanent)"

PREFIX_BIN="$PREFIX/bin"
cp ~/bin/tiks "$PREFIX_BIN/tiks"
chmod +x "$PREFIX_BIN/tiks"

if ! grep -q 'export PATH=$PATH:$HOME/bin' ~/.bashrc 2>/dev/null; then
    echo '' >> ~/.bashrc
    echo '# ═══ TikSaver PATH ═══' >> ~/.bashrc
    echo 'export PATH=$PATH:$HOME/bin' >> ~/.bashrc
fi

export PATH="$PATH:$HOME/bin"
echo -e "        ${G}✓${NC} ${DM}tiks installed to \$PREFIX/bin/tiks${NC}"

# ─── [5/5] Verify ───
step "[5/5]" "Verifying installation"

if [ -f "$PREFIX_BIN/tiks" ] && [ -x "$PREFIX_BIN/tiks" ]; then
    echo -e "        ${G}✓${NC} ${DM}tiks is ready${NC}"
    INSTALL_OK=true
elif [ -f ~/bin/tiks ] && [ -x ~/bin/tiks ]; then
    echo -e "        ${G}✓${NC} ${DM}tiks is ready (in ~/bin)${NC}"
    INSTALL_OK=true
else
    echo -e "        ${R}✗${NC} ${W}Installation failed${NC}"
    INSTALL_OK=false
fi

# ═══════════════════════════════════════════════════════════════
#  Final Animation
# ═══════════════════════════════════════════════════════════════
echo ""

if [ "$INSTALL_OK" = true ]; then
    # انیمیشن نهایی
    progress_bar 1.5 "finalizing..."
    
    echo ""
    stars
    echo ""
    
    echo -e "${G}  ╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${G}  ║${NC}                                                      ${G}║${NC}"
    echo -e "${G}  ║${NC}         ${BD}${W}🎉   I N S T A L L E D   🎉${NC}              ${G}║${NC}"
    echo -e "${G}  ║${NC}                                                      ${G}║${NC}"
    echo -e "${G}  ╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    sleep 0.3
    
    echo -e "  ${Y}⚡${NC} ${BD}${W}Quick Start${NC}"
    echo -e "  ${GR}─────────────────────────────────────${NC}"
    echo ""
    echo -e "  ${C}1.${NC} ${W}Download a video${NC}"
    echo -e "     ${DM}\$${NC} ${C}tiks${NC} ${GR}\"https://vt.tiktok.com/ZSxxxxx/\"${NC}"
    echo ""
    echo -e "  ${C}2.${NC} ${W}Show help${NC}"
    echo -e "     ${DM}\$${NC} ${C}tiks -h${NC}"
    echo ""
    echo -e "  ${C}3.${NC} ${W}Show version${NC}"
    echo -e "     ${DM}\$${NC} ${C}tiks -v${NC}"
    echo ""
    echo -e "  ${M}📁${NC} ${DM}Videos save to:${NC}"
    echo -e "     ${DM}/storage/emulated/0/Download/TikSaver/${NC}"
    echo ""
    echo -e "  ${G}✨${NC} ${BD}${W}tiks is ready — no restart needed!${NC}"
    echo ""
    echo -e "  ${M}🔗${NC} ${DM}github.com/${REPO}${NC}"
    echo ""
    echo -e "  ${G}Thanks for installing TikSaver! 💚${NC}"
    echo ""
    
    # تست
    echo -ne "  ${C}→${NC} ${DM}Testing installation...${NC}"
    sleep 0.6
    if command -v tiks &> /dev/null; then
        echo -e "\r  ${G}✓${NC} ${W}tiks is in PATH${NC}                    "
    else
        echo -e "\r  ${Y}⚠${NC} ${W}Run: source ~/.bashrc${NC}             "
    fi
    echo ""
    
else
    echo -e "${R}  ╔══════════════════════════════════════════════════════╗${NC}"
    echo -e "${R}  ║${NC}        ${BD}${W}✗   INSTALLATION FAILED   ✗${NC}              ${R}║${NC}"
    echo -e "${R}  ╚══════════════════════════════════════════════════════╝${NC}"
    echo ""
    exit 1
fi
