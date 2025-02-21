#!/usr/bin/env bash

# Configuration
DOMAINS_FILE="domains.txt"       # File containing list of domains (one per line)
SUBDOMAINS_FILE="subdomains.txt" # File to store subdomains

# Ensure required tools are installed
if ! command -v subfinder &>/dev/null; then
    echo "Error: subfinder not found. Please install it."
    exit 1
fi

if ! command -v anew &>/dev/null; then
    echo "Error: anew not found. Please install it."
    exit 1
fi

if ! command -v notify &>/dev/null; then
    echo "Error: notify not found. Please install it."
    exit 1
fi

# Main loop
while true; do
    echo -e "\e[32m"
    echo "   ██████╗ █████╗ ████████╗ ██████╗██╗  ██╗ ██╗████████╗"
    echo "  ██╔════╝██╔══██╗╚══██╔══╝██╔════╝██║  ██║ ██║╚══██╔══╝"
    echo "  ██║     ███████║   ██║   ██║     ███████║ ██║   ██║   "
    echo "  ██║     ██╔══██║   ██║   ██║     ██╔══██║ ██║   ██║   "
    echo "  ╚██████╗██║  ██║   ██║   ╚██████╗██║  ██║ ██║   ██║   "
    echo "   ╚═════╝╚═╝  ╚═╝   ╚═╝    ╚═════╝╚═╝  ╚═╝ ╚═╝   ╚═╝   "
    echo "        CATCH IT made by 19WHOAMI19"
    echo -e "\e[0m"

    echo "[*] Running subfinder on domains from $DOMAINS_FILE..."

    # Run subfinder, append new subdomains to SUBDOMAINS_FILE, notify, and check exit status
    if subfinder -silent -recursive -dL "$DOMAINS_FILE" -all | anew "$SUBDOMAINS_FILE" | notify -provider discord -bulk -id subdomains; then
        echo "[*] Subdomain enumeration completed. Sleeping for 6 hours..."
    else
        echo "[!] Error: subfinder failed. Check your input file or network connection."
    fi

    # Sleep for 6 hours (21600 seconds)
    sleep 21600
done
