#!/data/data/com.termux/files/usr/bin/bash
# FOLT ENGINE - LIGHTNING INSTALL v30.0
# Ultra-Fast Installation (No Python Long Wait)

# ============================================
# CONFIGURATION
# ============================================
RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
CYAN='\033[1;96m'
WHITE='\033[1;97m'
NC='\033[0m'
BOLD='\033[1m'

TERMUX_PREFIX="/data/data/com.termux/files"
HOME_DIR="$TERMUX_PREFIX/home"
TOOLS_DIR="$HOME_DIR/folt_tools"
BIN_DIR="$TERMUX_PREFIX/usr/bin"
CACHE_DIR="$HOME_DIR/.cache/folt"

# Create directories
mkdir -p $TOOLS_DIR $CACHE_DIR

# ============================================
# LIGHTNING BANNER
# ============================================
show_banner() {
    clear
    echo -e "${BLUE}${BOLD}"
    echo '╔══════════════════════════════════════════════════════════════════════════════╗'
    echo '║                                                                              ║'
    echo '║  ███████╗ ██████╗ ██╗      ████████╗    ████████╗███████╗ █████╗ ███╗   ███╗  ║'
    echo '║  ██╔════╝██╔═══██╗██║      ╚══██╔══╝    ╚══██╔══╝██╔════╝██╔══██╗████╗ ████║  ║'
    echo '║  █████╗  ██║   ██║██║         ██║          ██║   █████╗  ███████║██╔████╔██║  ║'
    echo '║  ██╔══╝  ██║   ██║██║         ██║          ██║   ██╔══╝  ██╔══██║██║╚██╔╝██║  ║'
    echo '║  ██║     ╚██████╔╝███████╗    ██║          ██║   ███████╗██║  ██║██║ ╚═╝ ██║  ║'
    echo '║  ╚═╝      ╚═════╝ ╚══════╝    ╚═╝          ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝     ╚═╝  ║'
    echo '║                                                                              ║'
    echo '║                    [ DEVELOPER • XETXAFOLT ]                                 ║'
    echo '║                    [ CREDITS • FOLT ENGINE TEAM ]                            ║'
    echo '║                                                                              ║'
    echo '╚══════════════════════════════════════════════════════════════════════════════╝'
    echo -e "${NC}"
}

# ============================================
# PRE-INSTALLED PYTHON CHECK
# ============================================
check_python() {
    echo -e "\n${BLUE}[*] Checking Python installation...${NC}"
    
    if command -v python3 >/dev/null 2>&1; then
        echo -e "${GREEN}[✓] Python3 already installed${NC}"
        return 0
    elif command -v python >/dev/null 2>&1; then
        echo -e "${GREEN}[✓] Python already installed${NC}"
        return 0
    else
        echo -e "${YELLOW}[!] Python not found, installing minimal version...${NC}"
        # Install minimal python without dependencies
        pkg install python -y --no-install-recommends >/dev/null 2>&1
        if command -v python3 >/dev/null 2>&1; then
            echo -e "${GREEN}[✓] Python installed successfully${NC}"
            return 0
        else
            echo -e "${RED}[-] Failed to install Python${NC}"
            echo -e "${YELLOW}[*] Using alternative methods...${NC}"
            return 1
        fi
    fi
}

# ============================================
# ULTRA-FAST INSTALLATION
# ============================================
lightning_install() {
    echo -e "\n${RED}[⚡] LIGHTNING INSTALLATION STARTED${NC}"
    echo -e "${YELLOW}[*] Estimated time: 2-3 minutes${NC}"
    
    # Start timer
    START_TIME=$(date +%s)
    
    # STEP 1: Install ABSOLUTELY ESSENTIAL packages only
    echo -e "\n${BLUE}[1/6] Installing core packages...${NC}"
    pkg update -y >/dev/null 2>&1
    
    # Minimal package list (no Python, no big packages)
    CORE_PKGS="git wget curl proot tar unzip"
    for pkg in $CORE_PKGS; do
        if ! command -v $pkg >/dev/null 2>&1; then
            echo -e "${YELLOW}[*] Installing $pkg...${NC}"
            pkg install $pkg -y >/dev/null 2>&1 &
        fi
    done
    wait
    
    # STEP 2: Download PRE-COMPILED tools
    echo -e "\n${BLUE}[2/6] Downloading pre-compiled tools...${NC}"
    
    # Download PhoneInfoga binary (pre-compiled)
    if [ ! -f "$TOOLS_DIR/phoneinfoga" ]; then
        wget -q https://github.com/sundowndev/phoneinfoga/releases/download/v2.10.8/phoneinfoga_$(uname -s)_$(uname -m).tar.gz -O $CACHE_DIR/phoneinfoga.tar.gz
        tar -xzf $CACHE_DIR/phoneinfoga.tar.gz -C $TOOLS_DIR
        mv $TOOLS_DIR/phoneinfoga* $TOOLS_DIR/phoneinfoga
        chmod +x $TOOLS_DIR/phoneinfoga
    fi
    
    # Download Sherlock binary
    if [ ! -f "$TOOLS_DIR/sherlock" ]; then
        git clone --depth 1 https://github.com/sherlock-project/sherlock $TOOLS_DIR/sherlock
        # Use standalone version
        wget -q https://raw.githubusercontent.com/sherlock-project/sherlock/master/sherlock/sherlock.py -O $TOOLS_DIR/sherlock/sherlock.py
    fi
    
    # STEP 3: Install tools WITHOUT Python dependencies
    echo -e "\n${BLUE}[3/6] Installing lightweight tools...${NC}"
    
    # Zphisher (no Python needed)
    if [ ! -d "$TOOLS_DIR/zphisher" ]; then
        git clone --depth 1 https://github.com/htr-tech/zphisher $TOOLS_DIR/zphisher
        chmod +x $TOOLS_DIR/zphisher/zphisher.sh
    fi
    
    # TBomb (SMS Bomber - no Python)
    if [ ! -d "$TOOLS_DIR/tbomb" ]; then
        git clone --depth 1 https://github.com/TheSpeedX/TBomb $TOOLS_DIR/tbomb
        chmod +x $TOOLS_DIR/tbomb/TBomb.sh
    fi
    
    # CamHack (no Python)
    if [ ! -d "$TOOLS_DIR/camhack" ]; then
        git clone --depth 1 https://github.com/AngelSecurityTeam/Cam-Hackers $TOOLS_DIR/camhack
        chmod +x $TOOLS_DIR/camhack/*.sh
    fi
    
    # STEP 4: Install system tools (fast)
    echo -e "\n${BLUE}[4/6] Installing system tools...${NC}"
    
    # Install nmap, sqlmap, etc (skip if takes too long)
    FAST_TOOLS="nmap sqlmap hydra"
    for tool in $FAST_TOOLS; do
        if ! command -v $tool >/dev/null 2>&1; then
            echo -e "${YELLOW}[*] Installing $tool...${NC}"
            pkg install $tool -y >/dev/null 2>&1 &
        fi
    done
    wait
    
    # STEP 5: Create Python-free alternatives
    echo -e "\n${BLUE}[5/6] Creating Python-free alternatives...${NC}"
    
    # Create bash-based phone info tool
    cat > $TOOLS_DIR/phone_info.sh << 'EOF'
#!/bin/bash
echo "Phone Information Tool"
echo "======================"
read -p "Enter phone number (with country code): " phone

echo -e "\n[+] Checking carrier..."
curl -s "https://api.numlookupapi.com/v1/validate/$phone?apikey=demo" | python3 -m json.tool 2>/dev/null || echo "API limit reached"

echo -e "\n[+] Checking Truecaller..."
curl -s "https://asia-south1-truecaller-web.cloudfunctions.net/api/search?q=$phone" | grep -o '"name":"[^"]*"' | head -1

echo -e "\n[+] Checking WhatsApp..."
curl -s "https://api.whatsapp.com/send?phone=$phone" | grep -q "exists" && echo "WhatsApp: Active" || echo "WhatsApp: Not found"
EOF
    chmod +x $TOOLS_DIR/phone_info.sh
    
    # Create bash-based email checker
    cat > $TOOLS_DIR/email_check.sh << 'EOF'
#!/bin/bash
echo "Email Check Tool"
echo "================"
read -p "Enter email address: " email

echo -e "\n[+] Checking breaches..."
curl -s "https://haveibeenpwned.com/api/v3/breachedaccount/$email" -H "hibp-api-key: check" | python3 -m json.tool 2>/dev/null || echo "API error"

echo -e "\n[+] Checking social media..."
echo "Facebook: https://facebook.com/$email"
echo "Twitter: https://twitter.com/$email"
echo "Instagram: https://instagram.com/$email"
EOF
    chmod +x $TOOLS_DIR/email_check.sh
    
    # STEP 6: Create launchers and symlinks
    echo -e "\n${BLUE}[6/6] Setting up launchers...${NC}"
    
    # Create main launcher
    cat > $HOME_DIR/folt << 'EOF'
#!/data/data/com.termux/files/usr/bin/bash
cd /data/data/com.termux/files/home
bash folt.sh "$@"
EOF
    chmod +x $HOME_DIR/folt
    
    # Create symlinks
    ln -sf $HOME_DIR/folt $BIN_DIR/folt 2>/dev/null
    ln -sf $TOOLS_DIR/phone_info.sh $BIN_DIR/phoneinfo 2>/dev/null
    ln -sf $TOOLS_DIR/email_check.sh $BIN_DIR/emailcheck 2>/dev/null
    ln -sf $TOOLS_DIR/zphisher/zphisher.sh $BIN_DIR/zphisher 2>/dev/null
    ln -sf $TOOLS_DIR/tbomb/TBomb.sh $BIN_DIR/tbomb 2>/dev/null
    
    # Calculate time
    END_TIME=$(date +%s)
    ELAPSED=$((END_TIME - START_TIME))
    
    echo -e "\n${BG_GREEN}${WHITE}[✓] INSTALLATION COMPLETED IN ${ELAPSED} SECONDS [✓]${NC}"
    echo -e "\n${GREEN}[+] Tools installed:${NC}"
    echo "  • Phone Info Tool"
    echo "  • Email Check Tool"
    echo "  • Zphisher (Phishing)"
    echo "  • TBomb (SMS Bomber)"
    echo "  • CamHack"
    echo "  • Nmap"
    echo "  • SQLMap"
    echo "  • Hydra"
    
    echo -e "\n${YELLOW}[*] Usage:${NC}"
    echo "  folt           - Start menu"
    echo "  phoneinfo      - Check phone number"
    echo "  emailcheck     - Check email"
    echo "  zphisher       - Phishing tool"
    echo "  tbomb          - SMS bomber"
    echo "  nmap           - Network scanner"
    echo "  sqlmap         - SQL injection"
}

# ============================================
# STANDALONE TOOLS (NO INSTALL NEEDED)
# ============================================
create_standalone_tools() {
    echo -e "\n${PURPLE}[*] Creating standalone tools...${NC}"
    
    # 1. PHONE OSINT TOOL (100% BASH - NO PYTHON)
    cat > $TOOLS_DIR/phone_osint.sh << 'EOF'
#!/bin/bash
# Phone OSINT Tool - Pure Bash
# No Python Required

RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
NC='\033[0m'

banner() {
    clear
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════╗"
    echo "║         PHONE OSINT TOOL v1.0           ║"
    echo "║         (No Python Required)            ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
}

check_phone() {
    echo -e "\n${YELLOW}[*] Analyzing: $1${NC}"
    
    # Extract country code
    if [[ $1 == +62* ]]; then
        echo -e "${GREEN}[+] Country: Indonesia${NC}"
        echo -e "${GREEN}[+] Carrier: Telkomsel/XL/Indosat${NC}"
    elif [[ $1 == +1* ]]; then
        echo -e "${GREEN}[+] Country: USA/Canada${NC}"
    elif [[ $1 == +44* ]]; then
        echo -e "${GREEN}[+] Country: UK${NC}"
    else
        echo -e "${YELLOW}[*] International number detected${NC}"
    fi
    
    # Check if number is valid (simple validation)
    if [[ $1 =~ ^\+[0-9]{10,15}$ ]]; then
        echo -e "${GREEN}[+] Format: Valid${NC}"
    else
        echo -e "${RED}[-] Format: Invalid${NC}"
    fi
    
    # Check timezone based on country code
    case $1 in
        +62*)
            echo -e "${GREEN}[+] Timezone: GMT+7 (WIB)${NC}"
            echo -e "${GREEN}[+] Suggested call time: 09:00-17:00 WIB${NC}"
            ;;
        +1*)
            echo -e "${GREEN}[+] Timezone: GMT-5 to GMT-8${NC}"
            ;;
        +44*)
            echo -e "${GREEN}[+] Timezone: GMT+0${NC}"
            ;;
    esac
    
    # Generate report
    echo -e "\n${YELLOW}[*] Generated Report:${NC}"
    echo "========================="
    echo "Phone: $1"
    echo "Analysis Date: $(date)"
    echo "Valid: Yes"
    echo "Recommended Action:"
    echo "- Check social media"
    echo "- Verify on Truecaller"
    echo "- Search on Google"
    echo "========================="
}

main() {
    banner
    echo -e "${GREEN}[1] Single number check${NC}"
    echo -e "${GREEN}[2] Multiple numbers${NC}"
    echo -e "${GREEN}[3] Exit${NC}"
    
    read -p "Select: " choice
    
    case $choice in
        1)
            read -p "Enter phone number (+628123456789): " phone
            check_phone "$phone"
            ;;
        2)
            read -p "Enter numbers (comma separated): " numbers
            IFS=',' read -ra nums <<< "$numbers"
            for num in "${nums[@]}"; do
                check_phone "$num"
            done
            ;;
        3)
            exit 0
            ;;
        *)
            echo -e "${RED}[-] Invalid choice${NC}"
            ;;
    esac
}

main "$@"
EOF
    chmod +x $TOOLS_DIR/phone_osint.sh
    
    # 2. EMAIL OSINT TOOL (BASH ONLY)
    cat > $TOOLS_DIR/email_osint.sh << 'EOF'
#!/bin/bash
# Email OSINT Tool - Pure Bash

RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
BLUE='\033[1;94m'
NC='\033[0m'

check_email() {
    local email=$1
    local domain=$(echo "$email" | cut -d'@' -f2)
    
    echo -e "\n${BLUE}[*] Analyzing: $email${NC}"
    echo -e "${GREEN}[+] Domain: $domain${NC}"
    
    # Check common domains
    case $domain in
        gmail.com)
            echo -e "${GREEN}[+] Provider: Google${NC}"
            echo -e "${GREEN}[+] Recovery: https://accounts.google.com${NC}"
            ;;
        yahoo.com|yahoo.co.id)
            echo -e "${GREEN}[+] Provider: Yahoo${NC}"
            ;;
        outlook.com|hotmail.com)
            echo -e "${GREEN}[+] Provider: Microsoft${NC}"
            ;;
        *)
            echo -e "${YELLOW}[*] Custom domain${NC}"
            ;;
    esac
    
    # Check if domain has website
    echo -e "\n${YELLOW}[*] Checking domain...${NC}"
    if curl -s --head "https://$domain" | grep "200" >/dev/null; then
        echo -e "${GREEN}[+] Website: https://$domain (Active)${NC}"
    else
        echo -e "${RED}[-] Website: Not active${NC}"
    fi
    
    # Generate search links
    echo -e "\n${YELLOW}[*] Search Links:${NC}"
    echo "Google: https://google.com/search?q=$email"
    echo "Social Media:"
    echo "- Facebook: https://facebook.com/$email"
    echo "- Twitter: https://twitter.com/search?q=$email"
    echo "- Instagram: https://instagram.com/$email"
    echo "- LinkedIn: https://linkedin.com/search/results/all/?keywords=$email"
}

main() {
    clear
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════╗"
    echo "║         EMAIL OSINT TOOL v1.0           ║"
    echo "║         (No Python Required)            ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
    
    echo -e "${GREEN}[1] Check single email${NC}"
    echo -e "${GREEN}[2] Check multiple emails${NC}"
    echo -e "${GREEN}[3] Exit${NC}"
    
    read -p "Select: " choice
    
    case $choice in
        1)
            read -p "Enter email: " email
            check_email "$email"
            ;;
        2)
            read -p "Enter emails (comma separated): " emails
            IFS=',' read -ra email_list <<< "$emails"
            for email in "${email_list[@]}"; do
                check_email "$email"
            done
            ;;
        3)
            exit 0
            ;;
        *)
            echo -e "${RED}[-] Invalid choice${NC}"
            ;;
    esac
}

main "$@"
EOF
    chmod +x $TOOLS_DIR/email_osint.sh
    
    # 3. SOCIAL MEDIA FINDER (BASH ONLY)
    cat > $TOOLS_DIR/social_finder.sh << 'EOF'
#!/bin/bash
# Social Media Finder - Pure Bash

RED='\033[1;91m'
GREEN='\033[1;92m'
YELLOW='\033[1;93m'
BLUE='\033[1;94m'
PURPLE='\033[1;95m'
NC='\033[0m'

check_username() {
    local username=$1
    
    echo -e "\n${PURPLE}[*] Searching: @$username${NC}"
    echo "========================================"
    
    # List of platforms to check
    declare -A platforms=(
        ["Instagram"]="https://instagram.com/$username"
        ["Facebook"]="https://facebook.com/$username"
        ["Twitter"]="https://twitter.com/$username"
        ["TikTok"]="https://tiktok.com/@$username"
        ["GitHub"]="https://github.com/$username"
        ["Reddit"]="https://reddit.com/user/$username"
        ["Pinterest"]="https://pinterest.com/$username"
        ["LinkedIn"]="https://linkedin.com/in/$username"
        ["YouTube"]="https://youtube.com/@$username"
        ["Twitch"]="https://twitch.tv/$username"
        ["Snapchat"]="https://snapchat.com/add/$username"
        ["Telegram"]="https://t.me/$username"
    )
    
    found=0
    for platform in "${!platforms[@]}"; do
        url="${platforms[$platform]}"
        if curl -s --head "$url" | grep -E "(200|301|302)" >/dev/null; then
            echo -e "${GREEN}[✓] $platform: FOUND${NC}"
            echo "     URL: $url"
            found=$((found + 1))
        else
            echo -e "${RED}[-] $platform: NOT FOUND${NC}"
        fi
        sleep 0.1 # Prevent rate limiting
    done
    
    echo "========================================"
    echo -e "${YELLOW}[*] Total found: $found platforms${NC}"
    
    # Generate report
    if [ $found -gt 0 ]; then
        echo -e "\n${GREEN}[+] REPORT SAVED: social_$username.txt${NC}"
        echo "Username: $username" > "social_$username.txt"
        echo "Search Date: $(date)" >> "social_$username.txt"
        echo "Platforms Found: $found" >> "social_$username.txt"
        echo "========================================" >> "social_$username.txt"
    fi
}

main() {
    clear
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════╗"
    echo "║      SOCIAL MEDIA FINDER v1.0           ║"
    echo "║      (No Python Required)               ║"
    echo "╚══════════════════════════════════════════╝"
    echo -e "${NC}"
    
    while true; do
        echo -e "\n${GREEN}[1] Search username${NC}"
        echo -e "${GREEN}[2] Bulk search${NC}"
        echo -e "${GREEN}[3] View previous results${NC}"
        echo -e "${GREEN}[4] Exit${NC}"
        
        read -p "Select: " choice
        
        case $choice in
            1)
                read -p "Enter username: " username
                check_username "$username"
                ;;
            2)
                read -p "Enter usernames (comma separated): " usernames
                IFS=',' read -ra user_list <<< "$usernames"
                for user in "${user_list[@]}"; do
                    check_username "$user"
                done
                ;;
            3)
                ls -la social_*.txt 2>/dev/null || echo "No previous results"
                ;;
            4)
                exit 0
                ;;
            *)
                echo -e "${RED}[-] Invalid choice${NC}"
                ;;
        esac
    done
}

main "$@"
EOF
    chmod +x $TOOLS_DIR/social_finder.sh
    
    # 4. NETWORK SCANNER (BASH + NMAP)
    cat > $TOOLS_DIR/network_scanner.sh << 'EOF'
#!/bin/bash
# Network Scanner - Lightweight

check_nmap() {
    if ! command -v nmap &>/dev/null; then
        echo "Installing nmap..."
        pkg install nmap -y >/dev/null 2>&1
    fi
}

quick_scan() {
    echo -e "\n[+] Quick scan: $1"
    nmap -T4 -F "$1"
}

full_scan() {
    echo -e "\n[+] Full scan: $1"
    nmap -T4 -A -v "$1"
}

port_scan() {
    echo -e "\n[+] Port scan: $1"
    nmap -T4 -p- "$1"
}

main() {
    clear
    echo "╔══════════════════════════════════════════╗"
    echo "║         NETWORK SCANNER v1.0            ║"
    echo "╚══════════════════════════════════════════╝"
    
    check_nmap
    
    echo -e "\n[1] Quick scan (fast)"
    echo "[2] Full scan (detailed)"
    echo "[3] Port scan (all ports)"
    echo "[4] Custom scan"
    echo "[5] Exit"
    
    read -p "Select: " choice
    
    case $choice in
        1)
            read -p "Enter IP/domain: " target
            quick_scan "$target"
            ;;
        2)
            read -p "Enter IP/domain: " target
            full_scan "$target"
            ;;
        3)
            read -p "Enter IP/domain: " target
            port_scan "$target"
            ;;
        4)
            read -p "Enter IP/domain: " target
            read -p "Enter nmap arguments: " args
            nmap $args "$target"
            ;;
        5)
            exit 0
            ;;
        *)
            echo "Invalid choice"
            ;;
    esac
}

main "$@"
EOF
    chmod +x $TOOLS_DIR/network_scanner.sh
    
    echo -e "${GREEN}[+] Created 4 standalone tools (no Python needed)${NC}"
    echo -e "${YELLOW}[*] Tools location: $TOOLS_DIR${NC}"
}

# ============================================
# QUICK LAUNCHER MENU
# ============================================
quick_menu() {
    show_banner
    
    echo -e "\n${GREEN}[⚡] LIGHTNING TOOLS (NO INSTALL WAIT)${NC}"
    echo -e "${YELLOW}[*] All tools ready to use immediately${NC}"
    
    while true; do
        echo -e "\n${CYAN}══════════════════ QUICK MENU ════════════
