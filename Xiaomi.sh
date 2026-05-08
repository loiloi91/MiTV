cat << 'EOF' > xiaomi.sh
#!/bin/bash
R='\e[1;31m'; O='\e[38;5;208m'; Y='\e[1;33m'; G='\e[1;32m'; B='\e[1;34m'; P='\e[1;35m'; C='\e[1;36m'; NC='\e[0m'; M='\e[1;35m'
GH="https://raw.githubusercontent.com/loiloi91/MiTV/main"
DIR="/sdcard/apk"
mkdir -p $DIR

show_header() {
    clear
    echo -e "${R}██╗  ██╗██╗ █████╗  ██████╗ ███╗   ███╗██╗${NC}"
    echo -e "${O}╚██╗██╔╝██║██╔══██╗██╔═══██╗████╗ ████║██║${NC}"
    echo -e "${Y} ╚███╔╝ ██║███████║██║   ██║██╔████╔██║██║${NC}"
    echo -e "${G} ██╔██╗ ██║██╔══██║██║   ██║██║╚██╔╝██║██║${NC}"
    echo -e "${B}██╔╝ ██╗██║██║  ██║╚██████╔╝██║ ╚═╝ ██║██║${NC}"
    echo -e "${P}╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝${NC}"
    echo -e "${M}       --- L O I  L O I  3 6 8 ---${NC}"
    echo -e "🛠️  CÙNG VỌC TIVI ĐỂ BÁN XÁC NÀO 💣💣💣"
    echo -e "⚡ CỐ LÊN CÁC CON VỢ 🤣"
    echo -e "${C}------------------------------------------------${NC}"
}

while true; do
    show_header
    echo -e "${R}[1]${NC} ${C}🔌 KẾT NỐI ADB QUA IP${NC}"
    echo -e "${O}[2]${NC} ${C}📡 TỰ ĐỘNG TẢI APK VỀ MÁY${NC}"
    echo -e "${Y}[3]${NC} ${C}🛠️  TRIỂN KHAI HỆ THỐNG LÕI   (Launcher, Voice)${NC}"
    echo -e "${G}[4]${NC} ${C}🔑 KÍCH HOẠT ĐẶC QUYỀN NGẦM  (Tiếng Việt & Quyền)${NC}"
    echo -e "${B}[5]${NC} ${R}🧹 TIÊU DIỆT APP RÁC & ADS   (Làm sạch Tivi)${NC}"
    echo -e "${P}[x]${NC} ${R}💀 ĐÓNG HỆ THỐNG${NC}"
    echo -e "${C}------------------------------------------------${NC}"
    echo -ne "${Y}❯ LỆNH ĐIỀU KHIỂN: ${NC}"
    read choice
    case $choice in
        1) echo -ne "${Y}❯ Nhập IP Tivi: ${NC}"; read ip; adb connect $ip; read -p "Nhấn Enter...";;
        2) echo -e "\n${B}[*] Đang tải file từ GitHub loiloi91...${NC}"
           for f in "DLStore_v16.0.3.apk" "LeanKeyboard_6.1.28.apk" "ProjectivyLauncher.apk" "voice.apk"; do
           echo -ne "${Y}  > Tải $f... ${NC}"; curl -L "$GH/$f" -o "$DIR/$f" --silent && echo -e "${G}[OK]${NC}" || echo -e "${R}[LỖI]${NC}"; done
           read -p "Xong! Nhấn Enter...";;
        3) echo -e "\n${Y}[*] Đang cài bộ app lõi lên TV...${NC}"
           for f in "DLStore_v16.0.3.apk" "LeanKeyboard_6.1.28.apk" "ProjectivyLauncher.apk" "voice.apk"; do
           if [ -f "$DIR/$f" ]; then echo -ne "${C}  > Cài $f... ${NC}"; adb install -r "$DIR/$f" >/dev/null 2>&1 && echo -e "${G}[XONG]${NC}" || echo -e "${R}[LỖI]${NC}"; fi; done
           read -p "Xong! Nhấn Enter...";;
        4) echo -e "\n${P}[*] Đang kích hoạt Tiếng Việt...${NC}"
           adb shell settings put global system_locales vi-VN
           adb shell pm grant com.spocky.projectivylauncher android.permission.WRITE_SECURE_SETTINGS
           echo -e "${G}✅ THÀNH CÔNG!${NC}"; read -p "Nhấn Enter...";;
        5) echo -e "\n${R}[*] ĐANG GỠ APP RÁC...${NC}"
           apps=("com.miui.video" "com.miui.player" "com.xiaomi.mitv.advertise" "com.xiaomi.mipush" "com.android.providers.downloads.ui" "com.xiaomi.mitv.services" "com.xiaomi.mitv.shop")
           for app in "${apps[@]}"; do echo -ne "${Y}  > Gỡ $app... ${NC}"; adb shell pm uninstall --user 0 $app >/dev/null 2>&1 && echo -e "${G}[SẠCH]${NC}" || echo -e "${R}[BỎ QUA]${NC}"; done
           read -p "Xong! Nhấn Enter...";;
        [xX]) exit 0;;
        *) sleep 1;;
    esac
done
EOF
chmod +x xiaomi.sh && ./xiaomi.sh
