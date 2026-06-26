# macOS Bloatware Freezer Script

A lightweight, non-destructive Bash script to disable and freeze stubborn background processes, widgets, and Siri intents for pre-installed macOS applications that you don't use. 

Since modern macOS versions protect the system volume via **Signed System Volume (SSV)**, you cannot directly delete stock apps like *News*, *Home*, or *Weather*. However, this script completely freezes their CPU/RAM footprint by hunting down and disabling their underlying `LaunchAgents`, `LaunchDaemons`, and hidden App Extensions (`.appex`).

## 🚫 What This Script Disables

This script targets and shuts down both the core agents and hidden widget/Siri extensions for the following **9 apps**:
1. **News.app** (Core daemon, Today widgets, News tags, and Siri intents)
2. **Home.app** (Homed daemon, HomeHub syncing, Interactive & Energy widgets)
3. **Stocks.app** (Stocks daemon and finance widgets)
4. **Weather.app** (Weather daemon, forecast widgets, and Siri intents)
5. **Journal.app** (Journaling daemon and secure widgets)
6. **Podcasts.app** (Podcast agent and background widgets)
7. **VoiceMemos.app** (VoiceMemos daemon, Quick Record & Settings extensions)
8. **Calendar.app** (Background CalendarAgent, calendar widgets, and Siri intents)
9. **Clock.app** (Remote clock daemon, main widgets, and World Clock extensions)

---

## 🚀 How to Use

### 1. Clone or Download the Script
Open your **Terminal** and create the script file:
```bash
nano debloat_mac.sh
```

*Paste the contents of `debloat_mac.sh` into the editor, press `Ctrl + O` then `Enter` to save, and `Ctrl + X` to exit.*

### 2. Make the Script Executable

Give the script permission to run:

```bash
chmod +x debloat_mac.sh
```

### 3. Run the Script

Execute the script:

```bash
./debloat_mac.sh
```

> **Note:** The script might prompt you for your administrator password (`sudo`) because disabling certain system-level background processes requires root privileges.

---

## 🌐 Cloudflare WARP Control (`warp.sh`)

If you use Cloudflare WARP but want to completely stop and freeze its background daemon and GUI client when not in use (saving RAM, CPU, and battery), you can use the `warp.sh` script.

### 1. Make the Script Executable

```bash
chmod +x warp.sh
```

### 2. Turn Cloudflare WARP OFF

To stop the daemon, prevent it from auto-starting, and close the running GUI client:

```bash
sudo ./warp.sh off
```

### 3. Turn Cloudflare WARP ON

To re-enable and start the background daemon:

```bash
sudo ./warp.sh on
```

---

## 🔍 Verification

To verify that the applications and their hidden extensions are no longer wasting your RAM/CPU, you can audit them using the `ps` command. For example:

```bash
ps aux | grep -i Home.app
```

**Expected Result:** You should only see the single `grep` command itself running. All background widget pipelines (`.appex`) are successfully terminated.

---

## 🔄 How to Reverse (Re-enable Apps)

If you ever change your mind and want to use any of these apps again, you can easily re-enable their services via `launchctl`. For example, to bring back the **News** app:

```bash
launchctl enable user/$UID/com.apple.newsd
```

## ⚠️ Disclaimer

This script is completely safe and **does not modify or delete system files**. It only alters user-level configurations to prevent unneeded background daemons from launching. Feel free to fork and customize it to fit your workflow!
