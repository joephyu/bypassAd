#!/bin/bash
GREEN='\033[0;32m'
NC='\033[0m'
clear
show_menu() {
echo -e "${GREEN}"
echo -e " ____   _    ____ ____       _    ____  ____  "
echo -e "|  _ \ / \  / ___/ ___|     / \  |  _ \/ ___| "
echo -e "| |_) / _ \ \___ \___ \    / _ \ | | | \___ \ "
echo -e "|  __/ ___ \ ___) |__) |  / ___ \| |_| |___) |"
echo -e "|_| /_/   \_\____/____/  /_/   \_\____/|____/ "
echo -e "               PASS ADS TOOLKIT               "
echo -e "${NC}"
# -------------------------------
# ✅ Bypassed Link Toolkit
# -------------------------------

  echo -e "${GREEN}========== Bypassed Link Toolkit ==========${NC}"
  echo -e "${GREEN} (1) Visit ChannelMyanmar Website${NC}"
  echo -e "${GREEN} (2) Copy your favorite link (copy/paste)${NC}"
  echo -e "${GREEN} (3) Guide: Block Ads using Private DNS${NC}"
  echo -e "${GREEN} (4) ADB Shell: Block Ads via Package Manager${NC}"
  echo -e "${GREEN} (0) Exit${NC}"
  echo -e "${GREEN}==========================================${NC}"
}

visit_cm_site() {
  clear
  url="https://www.channelmyanmar.to"
  echo -e "🌐 Opening ${GREEN}$url${NC} in browser..."
  if command -v xdg-open > /dev/null; then
    xdg-open "$url" &
  else
    echo "❗ Cannot open browser (xdg-open not found)."
  fi
  read -rp "🔁 Press Enter to continue..." dummy
  clear
}

decode_and_open() {
  clear
  read -rp "🔗 Paste your full CM link with ?r= : " fullurl
  encoded=$(echo "$fullurl" | grep -oP 'r=\K[^&]+')

  if [ -z "$encoded" ]; then
    echo "❌ No 'r=' parameter found."
    read -rp "🔁 Press Enter to continue..." dummy
    clear
    return
  fi

  decoded=$(echo "$encoded" | base64 --decode 2>/dev/null)
  if [ $? -ne 0 ] || [ -z "$decoded" ]; then
    echo "❌ Failed to decode base64."
    read -rp "🔁 Press Enter to continue..." dummy
    clear
    return
  fi

  echo -e "✅ Decoded URL: ${GREEN}$decoded${NC}"

  if command -v xdg-open > /dev/null; then
    read -rp "🌐 Open in browser? [y/N]: " open
    [[ "$open" =~ ^[Yy]$ ]] && xdg-open "$decoded" &
  fi
  read -rp "🔁 Press Enter to continue..." dummy
  clear
}

adblock_dns_guide() {
  clear
  echo -e "${GREEN}📱 Private DNS Setup (AdGuard)${NC}"
  echo "----------------------------------------"
  echo "1. Open your phone Settings."
  echo "2. Go to: Network & Internet > Private DNS"
  echo "3. Choose: 'Private DNS provider hostname'"
  echo "4. Enter:  dns.adguard.com"
  echo "5. Tap Save ✅"
  echo ""
  echo "🔒 Now ads will be blocked system-wide (some apps may still bypass)."
  read -rp "🔁 Press Enter to continue..." dummy
  clear
}

adb_block_ads() {
  clear
  echo "📲 Make sure:"
  echo " - Developer Options is enabled on your phone"
  echo " - Wireless debugging is turned ON"
  echo " - Run: adb pair IP:PORT  (if needed)"
  echo " - Then connect with: adb connect IP:PORT"
  echo ""

  read -rp "▶️ Ready to run ADB commands to disable ad packages? [y/N]: " confirm
  if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
    read -rp "🔁 Press Enter to return to menu..." dummy
    clear
    return
  fi

  echo "⏳ Disabling known ad apps/services..."
  adb shell pm disable-user --user 0 com.google.android.gms.ads
  adb shell pm disable-user --user 0 com.facebook.katana
  adb shell pm disable-user --user 0 com.facebook.services
  adb shell pm disable-user --user 0 com.facebook.system
  adb shell pm disable-user --user 0 com.miui.systemAdSolution
  adb shell pm disable-user --user 0 com.miui.analytics
  adb shell pm disable-user --user 0 com.android.browser
  adb shell pm disable-user --user 0 com.android.adservices
  echo -e "${GREEN}✅ Done. You may reboot your device.${NC}"
  read -rp "🔁 Press Enter to continue..." dummy
  clear
}

# Main loop
while true; do
  show_menu
  read -rp "👉 Choose (0-4): " choice
  case $choice in
    1) visit_cm_site ;;
    2) decode_and_open ;;
    3) adblock_dns_guide ;;
    4) adb_block_ads ;;
    0) echo "👋 Exiting..."; exit 0 ;;
    *) echo "❗ Invalid choice. Please enter 0-4."; read -rp "🔁 Press Enter to continue..." dummy; clear ;;
  esac
done
