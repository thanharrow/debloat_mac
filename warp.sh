#!/bin/bash

# Path to Cloudflare WARP daemon configuration file
DAEMON_PLIST="/Library/LaunchDaemons/com.cloudflare.1dot1dot1dot1.macos.warp.daemon.plist"
DAEMON_ID="system/com.cloudflare.1dot1dot1dot1.macos.warp.daemon"

# Check if the user did not pass arguments or passed incorrect ones
if [ "$1" != "on" ] && [ "$1" != "off" ]; then
    echo "❌ Usage: bash warp.sh [on|off]"
    exit 1
fi

# Require root privileges (sudo) since this is a system service
if [ "$EUID" -ne 0 ]; then
    echo "🔒 This script requires root privileges. Please run with sudo or enter your password below:"
    exec sudo bash "$0" "$@"
fi

# Handle 'off' argument
if [ "$1" == "off" ]; then
    echo "[+] Stopping Cloudflare WARP background daemon and client..."
    launchctl unload -w "$DAEMON_PLIST" 2>/dev/null
    launchctl disable "$DAEMON_ID" 2>/dev/null
    killall "Cloudflare WARP" 2>/dev/null
    killall CloudflareWARP 2>/dev/null
    echo "✅ WARP daemon and client have been successfully turned OFF and frozen."

# Handle 'on' argument
elif [ "$1" == "on" ]; then
    echo "[+] Starting Cloudflare WARP background daemon..."
    launchctl enable "$DAEMON_ID" 2>/dev/null
    launchctl load -w "$DAEMON_PLIST" 2>/dev/null
    echo "✅ WARP daemon has been successfully turned ON."
fi