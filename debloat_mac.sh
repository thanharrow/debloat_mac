#!/bin/bash

echo "============================================="
echo "  STARTING COMPLETE DEBLOAT OF UNUSED APPS  "
echo "  (DISABLING BACKGROUND SERVICES & WIDGETS)  "
echo "============================================="

# Helper function to disable background services
disable_agent() {
    local agent=$1
    launchctl unload -w "/System/Library/LaunchAgents/${agent}.plist" 2>/dev/null
    launchctl disable "user/$UID/${agent}" 2>/dev/null
}

# 1. News.app (News + Widgets + Siri Intents)
echo "[+] Disabling News background daemon and widgets..."
disable_agent "com.apple.newsd"
disable_agent "com.apple.newssaved"
launchctl disable "user/$UID/com.apple.news.widget" 2>/dev/null
launchctl disable "user/$UID/com.apple.news.widget.today" 2>/dev/null
launchctl disable "user/$UID/com.apple.news.NewsTodayIntents" 2>/dev/null
launchctl disable "user/$UID/com.apple.news.tag" 2>/dev/null
killall newsd NewsTodayIntents NewsTag NewsToday2 2>/dev/null

# 2. Home.app (Smart Home + All Widgets)
echo "[+] Disabling Home daemon and widgets..."
disable_agent "com.apple.homed"
disable_agent "com.apple.Home.HomeHub"
launchctl disable "user/$UID/com.apple.Home.HomeWidget.Interactive" 2>/dev/null
launchctl disable "user/$UID/com.apple.Home.HomeWidget" 2>/dev/null
launchctl disable "user/$UID/com.apple.Home.HomeEnergyWidgets" 2>/dev/null
killall homed HomeWidget HomeEnergyWidgetsExtension 2>/dev/null

# 3. Stocks.app (Stocks + Widgets)
echo "[+] Disabling Stocks daemon and widgets..."
disable_agent "com.apple.stocksd"
launchctl disable "user/$UID/com.apple.stocks.widget" 2>/dev/null
killall stocksd StocksWidget 2>/dev/null

# 4. Weather.app (Weather + Widgets + Siri Intents)
echo "[+] Disabling Weather daemon, widgets, and Siri intents..."
disable_agent "com.apple.weatherd"
launchctl disable "user/$UID/com.apple.weather.widget" 2>/dev/null
launchctl disable "user/$UID/com.apple.weather.WeatherIntents" 2>/dev/null
killall weatherd WeatherWidget WeatherIntents 2>/dev/null

# 5. Journal.app (Journal + Secure Widgets)
echo "[+] Disabling Journal daemon and secure widgets..."
disable_agent "com.apple.journald"
launchctl disable "user/$UID/com.apple.journal.widgets.secure" 2>/dev/null
launchctl disable "user/$UID/com.apple.journal.widgets" 2>/dev/null
killall journald JournalWidgetsSecure JournalWidgets 2>/dev/null

# 6. Podcasts.app (Podcasts + Widgets)
echo "[+] Disabling Podcasts agent and widgets..."
disable_agent "com.apple.podcasts"
disable_agent "com.apple.podcasts.PodcastAgent"
launchctl disable "user/$UID/com.apple.podcasts.widget" 2>/dev/null
killall PodcastAgent PodcastsWidget 2>/dev/null

# 7. VoiceMemos.app (Voice Memos + Widgets)
echo "[+] Disabling Voice Memos daemon and recording widgets..."
disable_agent "com.apple.voicememod"
launchctl disable "user/$UID/com.apple.VoiceMemos.VoiceMemosSettingsWidget" 2>/dev/null
launchctl disable "user/$UID/com.apple.VoiceMemos.RecordWidget" 2>/dev/null
killall voicememod VoiceMemosSettingsWidgetExtension RecordWidgetExtension 2>/dev/null

# 8. Calendar.app (Calendar Agent + Widgets + Siri Intents)
echo "[+] Disabling Calendar agent, widgets, and Siri intents..."
disable_agent "com.apple.CalendarAgent"
launchctl disable "user/$UID/com.apple.calendar.widget" 2>/dev/null
launchctl disable "user/$UID/com.apple.iCal.CalendarWidgetExtension" 2>/dev/null
launchctl disable "user/$UID/com.apple.calendar.CalendarIntentsExtension" 2>/dev/null
killall CalendarAgent CalendarWidget CalendarWidgetExtension CalendarIntentsExtension 2>/dev/null

# 9. Clock.app (Clock daemon + All Widgets)
echo "[+] Disabling Clock daemon and widgets..."
disable_agent "com.apple.remotedclockd"
launchctl disable "user/$UID/com.apple.clock.widget" 2>/dev/null
launchctl disable "user/$UID/com.apple.clock.WorldClockWidget" 2>/dev/null
killall remotedclockd ClockWidget WorldClockWidget 2>/dev/null

# Clear system cache of services to apply changes immediately
echo "[+] Clearing system cache to apply configurations..."
killall Dock 2>/dev/null
killall Finder 2>/dev/null
killall NotificationCenter 2>/dev/null

echo "============================================="
echo "  DEBLOAT COMPLETE! YOUR MAC IS NOW CLEAN.   "
echo "============================================="
