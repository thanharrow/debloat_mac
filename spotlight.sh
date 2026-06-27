#!/bin/bash

# Check if the user did not pass arguments or passed incorrect ones
if [ "$1" != "on" ] && [ "$1" != "off" ]; then
    echo "❌ Usage: bash spotlight.sh [on|off]"
    exit 1
fi

# Require root privileges (sudo) since modifying global spotlight indexing requires root
if [ "$EUID" -ne 0 ]; then
    echo "🔒 This script requires root privileges. Please run with sudo or enter your password below:"
    exec sudo bash "$0" "$@"
fi

# Handle 'off' argument
if [ "$1" == "off" ]; then
    echo "[+] Disabling Spotlight indexing for all volumes..."
    mdutil -a -i off 2>/dev/null
    mdutil -E / 2>/dev/null
    echo "✅ Spotlight indexing has been successfully turned OFF."

# Handle 'on' argument
elif [ "$1" == "on" ]; then
    echo "[+] Enabling Spotlight indexing for all volumes..."
    mdutil -a -i on 2>/dev/null
    mdutil -E / 2>/dev/null
    echo "✅ Spotlight indexing has been successfully turned ON."
fi
