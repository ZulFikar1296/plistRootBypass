#!/bin/bash

echo "🔄 Clearing RAM caches..."

# Purge RAM (works in macOS Recovery Mode)
purge

# Ensure swap memory is cleared (if swap is enabled)
if [ -f /private/var/vm/swapfile* ]; then
    rm -f /private/var/vm/swapfile*
fi

# Sync to ensure RAM is flushed
sync; sync; sync

echo "✅ RAM caches cleared!"

echo "🔄 Booting into Apple Official Recovery Mode..."

# Force Reboot to Official Apple Internet Recovery
nvram internet-recovery-mode=on
reboot