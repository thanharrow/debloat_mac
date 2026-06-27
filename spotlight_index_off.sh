#!/bin/bash

echo "============================================="
echo "  DISABLE SPOTLIGHT INDEXING (INDEX OFF)     "
echo "============================================="

if [ "$EUID" -ne 0 ]; then
    echo "🔒 This script requires sudo privileges. Please enter your password:"
    exec sudo bash "$0" "$@"
fi

# Completely disable drive indexing
mdutil -a -i off 2>/dev/null
mdutil -E / 2>/dev/null

echo "[+] File indexing disabled. Spotlight now has 0% performance impact!"