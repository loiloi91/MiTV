#!/bin/bash
R='\e[1;31m'; O='\e[38;5;208m'; Y='\e[1;33m'; G='\e[1;32m'; B='\e[1;34m'; P='\e[1;35m'; C='\e[1;36m'; NC='\e[0m'; M='\e[1;35m'
GH="https://raw.githubusercontent.com/loiloi91/MiTV/main"
# Sử dụng thư mục tạm bên trong Termux (Không lo lỗi quyền bộ nhớ)
DIR="$HOME/mitv_tmp"
mkdir -p "$DIR"

show_header() {
    clear
    echo -e "${R}██╗  ██╗██╗ █████╗  ██████╗ ███╗   ███╗██╗${NC}"
    echo -e "${O}╚██╗██╔╝██║██╔══██╗██╔═══██╗████╗ ████║██║${NC}"
    echo -e "${Y} ╚███╔╝ ██║███████║██║   ██║██╔████╔██║██║${NC}"
    echo -e "${G} ██╔██╗ ██║██╔══██║██║   ██║██║╚██╔╝██║██║${NC}"
    echo -e "${B}██╔╝ ██╗██║██║  ██║╚██████╔╝██║ ╚═╝ ██║██║${NC}"
    echo -e "${P}╚═╝  ╚═╝╚═╝╚═╝  ╚═╝ ╚═════╝ ╚═╝     ╚═╝╚═╝${NC}"
    echo -e "${M}       --- L O I  L O I  3 6 8 ---${NC}"
    echo -e "🛠️  TRẠM ĐIỀU KHIỂN TỐI ƯU MI TV${NC}"
    echo -e "${C}------------------------------------------------${NC}"
}

while true; do
    show_header
    echo -e "${R}[1]${NC} ${C}🔌 KẾT NỐI ADB QUA IP${NC}"
    echo -e "${O}[2]${NC} ${C}📡 TẢI BỘ APP TỪ HỆ THỐNG${NC}"
    echo -e "${Y}[3]${NC} ${C}🛠️  CÀI ĐẶT APP LÊN TIVI${NC}"
    echo -e "${G}[4]${NC} ${C}🔑 KÍCH HOẠT TIẾNG VIỆT & QUYỀN${NC}"
    echo -e "${B}[5]${NC} ${R}🧹 GỠ APP RÁC & QUẢNG CÁO${NC}"
    echo -e "${P}[x]${NC} ${R}💀 ĐÓNG HỆ THỐNG${NC}"
    echo -e "${C}------------------------------------------------${NC}"
    echo -ne "${Y}❯ LỆNH ĐIỀU KHIỂN: ${NC}"
    read choice
    case $choice in
        1) echo -ne "${Y}❯ Nhập IP Tivi: ${NC}"; read ip; adb connect $ip; read -p "Xong! Nhấn Enter...";;
        2) 
           echo -e "\n${B}[*] Đang tải bộ APK...${NC}"
           for f in "DLStore_v16.0.3.apk" "LeanKeyboard_6.1.28.apk" "ProjectivyLauncher.apk" "voice.apk"; do
           echo -ne "${Y}  > Tải $f... ${NC}"
           curl -L "$GH/$f" -o "$DIR/$f" --silent && echo -e "${G}[OK]${NC}" || echo -e "${R}[LỖI]${NC}"
           done
           read -p "Đã tải xong! Nhấn Enter để tiếp tục...";;
        3) 
           echo -e "\n${Y}[*] Đang cài đặt lên Tivi...${NC}"
           for f in "DLStore_v16.0.3.apk" "LeanKeyboard_6.1.28.apk" "ProjectivyLauncher.apk" "voice.apk"; do
           if [ -f "$DIR/$f" ]; then 
               echo -ne "${C}  > Đang cài $f... ${NC}"
               adb install -r "$DIR/$f" >/dev/null 2>&1 && echo -e "${G}[XONG]${NC}" || echo -e "${R}[THẤT BẠI]${NC}"
           else
               echo -e "${R}[!] Không tìm thấy file $f. Hãy chọn phím 2 trước!${NC}"
           fi
           done
           read -p "Hoàn tất cài đặt! Nhấn Enter...";;
        4) 
           echo -e "\n${P}[*] Đang xử lý lệnh đặc quyền...${NC}"
           adb shell settings put global system_locales vi-VN
           adb shell pm grant com.spocky.projectivylauncher android.permission.WRITE_SECURE_SETTINGS
           echo -e "${G}✅ ĐÃ KÍCH HOẠT TIẾNG VIỆT!${NC}"; read -p "Nhấn Enter...";;
        5) 
           echo -e "\n${R}[*] ĐANG DỌN RÁC TIVI...${NC}"
           apps=("com.miui.video" "com.miui.player" "com.xiaomi.mitv.advertise" "com.xiaomi.mipush" "com.android.providers.downloads.ui" "com.xiaomi.mitv.services" "com.xiaomi.mitv.shop")
           for app in "${apps[@]}"; do echo -ne "${Y}  > Đang gỡ $app... ${NC}"; adb shell pm uninstall --user 0 $app >/dev/null 2>&1 && echo -e "${G}[SẠCH]${NC}"; done
           read -p "Đã dọn xong! Nhấn Enter...";;
        [xX]) exit 0;;
        *) sleep 1;;
    esac
done
