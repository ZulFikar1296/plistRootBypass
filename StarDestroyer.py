import os
import subprocess
import time

# Function to execute system commands with admin privileges
def run_command(cmd):
    try:
        print(f"[*] Executing: {cmd}")
        result = subprocess.run(cmd, shell=True, check=True, text=True, capture_output=True)
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        print(f"[!] Error executing command: {cmd}\n{e.stderr}")
        return None

# Function to erase disk0 (Internal Drive)
def erase_internal_drive():
    print("[*] Unmounting internal drive...")
    run_command("diskutil unmountDisk force /dev/disk0")

    print("[*] Securely erasing internal drive (disk0)...")
    run_command("diskutil secureErase 2 /dev/disk0")  # "2" = 3-pass random overwrite

    print("[*] Drive wipe completed.")

# Function to clear RAM & swap
def clear_ram():
    print("[*] Clearing RAM...")
    run_command("sudo purge")

    print("[*] Disabling and re-enabling swap...")
    run_command("sudo swapoff -a && sudo swapon -a")

# Function to force reboot into macOS Recovery (M3)
def reboot_to_recovery():
    print("[*] Setting NVRAM to force Recovery Mode...")
    run_command("sudo nvram recovery-boot-mode=unused")
    time.sleep(2)

    print("[*] Rebooting into macOS Recovery...")
    run_command("sudo reboot")

# Bypass admin limitations (if possible)
def escalate_privileges():
    print("[*] Attempting to escalate privileges...")
    run_command("sudo -v")  # Refresh sudo timestamp

    # Attempt system bypass techniques
    run_command("sudo tccutil reset SystemPolicyAllFiles")  # Reset TCC permissions
    run_command("sudo spctl --master-disable")  # Disable Gatekeeper
    run_command("csrutil disable")  # Disable SIP (only in Recovery mode)
    run_command("launchctl bootout system/com.apple.ScreenTimeAgent")  # Kill Screen Time restrictions

# Confirm before execution
print("WARNING: This script will ERASE disk0, clear RAM, and force boot into macOS Recovery. Proceed? (yes/no)")
confirm = input().strip().lower()
if confirm != "yes":
    print("Aborted.")
    exit(1)

# Run the sequence
escalate_privileges()
erase_internal_drive()
clear_ram()
reboot_to_recovery()