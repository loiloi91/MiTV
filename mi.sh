#!/bin/bash
# Code by LOI LOI 368

show_menu() {
    clear
    echo -e "\e[1;31m██╗  ██╗██╗ █████╗  ██████╗ ███╗   ███╗██╗\e[0m"
    echo -e "\e[1;33m╚██╗██╔╝██║██╔══██╗██╔═══██╗████╗ ████║██║\e[0m"
    echo -e "\e[1;32m ╚███╔╝ ██║███████║██║   ██║██╔████╔██║██║\e[0m"
    echo -e "\e[1;34m ██╔██╗ ██║██╔══██║██║   ██║██║╚██╔╝██║██║\e[0m"
    echo -e "\e[1;35m██╔╝ ██╗██║██║  ██║╚██████╔╝██║ ╚═╝ ██║██║\e[0m"
    echo -e "      \e[1;35m--- L O I  L O I  3 6 8 ---\e[0m"
    echo -e " \e[1;32m🛠️  CÙNG VỌC TIVI ĐỂ BÁN XÁC NÀO 💣💣💣\e[0m"
    echo -e "    \e[1;33m⚡ CỐ LÊN CÁC CON VỢ CỦA ANH 🤣\e[0m"
    echo -e "\e[1;36m--------------------------------------------\e[0m"

    check_adb=$(adb devices | grep -v "List" | grep "device")
    if [ -n "$check_adb" ]; then
        model=$(adb shell getprop ro.product.model)
        echo -e "\e[1;32m✅ TV: $model - ĐÃ KẾT NỐI SẴN SÀNG\e[0m"
    else
        echo -e "\e[1;31m❌ CHƯA KẾT NỐI TIVI - VUI LÒNG CHỌN [1]\e[0m"
    fi
    echo -e "\e[1;36m--------------------------------------------\e[0m"

    echo -e "\e[1;31m[1]\e[0m 🔌 KẾT NỐI ADB QUA IP"
    echo -e "\e[1;33m[2]\e[0m 🚀 TẢI TẤT CẢ APK (PHẢI LÀM TRƯỚC)"
    echo -e "\e[1;36m--- CÀI ĐẶT RIÊNG BIỆT ---\e[0m"
    echo -e "\e[1;32m[3]\e[0m 📦 CÀI MSTORE        \e[1;32m[4]\e[0m 📦 CÀI PROJECTIVY"
    echo -e "\e[1;32m[5]\e[0m 📦 CÀI TIZENTUBE     \e[1;32m[6]\e[0m 📦 CÀI SUPERVOICE"
    echo -e "\e[1;32m[7]\e[0m 📦 CÀI VTV GO        \e[1;32m[8]\e[0m 📦 CÀI BÀN PHÍM LEAN"
    echo -e "\e[1;36m--- HỆ THỐNG CHUYÊN SÂU ---\e[0m"
    echo -e "\e[1;33m[9]\e[0m 🛠️  FIX MÀN ĐEN & MỞ LAUNCHER"
    echo -e "\e[1;33m[10]\e[0m 🔑 DỌN RÁC QUẢNG CÁO XIAOMI"
    echo -e "\e[1;31m[x]\e[0m 💀 THOÁT"
    echo ""
    echo -ne "\e[1;33m❯ LỆNH: \e[0m"
}

while true; do
    show_menu
    read chon
    case $chon in
        1) read -p "Nhập IP Tivi: " ip && adb connect $ip && adb shell settings put global install_non_market_apps 1 && sleep 2 ;;
        2) 
           echo -e "\e[1;31m⚡ ĐANG KÉO QUÂN TỪ GITHUB...\e[0m"
           base="https://raw.githubusercontent.com/loiloi91/MiTV/main"
           curl -L "$base/Mstore.apk" -o Mstore.apk
           curl -L "$base/ProjectivyLauncher.apk" -o ProjectivyLauncher.apk
           curl -L "$base/TizenTube108.apk" -o TizenTube108.apk
           curl -L "$base/voice.apk" -o voice.apk
           curl -L "$base/VTVgo111230.apk" -o VTVgo111230.apk
           curl -L "$base/LeanKeyboard.apk" -o LeanKeyboard.apk
           echo -e "\e[1;32m✅ Đã tải xong! Kiểm tra dung lượng:\e[0m"
           ls -lh *.apk
           sleep 3 ;;
        3) adb install -r -d -g Mstore.apk && sleep 2 ;;
        4) adb install -r -d -g ProjectivyLauncher.apk && sleep 2 ;;
        5) adb install -r -d -g TizenTube108.apk && sleep 2 ;;
        6) adb install -r -d -g voice.apk && sleep 2 ;;
        7) adb install -r -d -g VTVgo111230.apk && sleep 2 ;;
        8) adb install -r -d -g LeanKeyboard.apk && sleep 2 ;;
        9) 
            echo -e "\e[1;33m🛠️  Đang ép mở Projectivy (Bản Eng Menu)...\e[0m"
            pkg="com.spocky.projengmenu"
            adb shell appops set $pkg GET_USAGE_STATS allow
            adb shell settings put secure sysui_key_grab 1
            adb shell monkey -p $pkg -c android.intent.category.LAUNCHER 1
            echo -e "\e[1;32m✅ Đã mở xong! Con vợ nhìn Tivi xem.\e[0m"
            sleep 2 ;;
        10) 
            echo -e "\e[1;31m🧹 Đang quét dọn quảng cáo Xiaomi...\e[0m"
            ads=(
                "com.xiaomi.mitv.advertise"
                "com.xiaomi.mipush.sdk"
                "com.miui.systemads"
                "com.xiaomi.mitv.services"
                "com.xiaomi.mitv.promosystem"
            )
            for p in "${ads[@]}"; do
                echo -n "Đang xử lý $p: "
                adb shell pm uninstall --user 0 $p > /dev/null 2>&1
                adb shell pm disable-user --user 0 $p > /dev/null 2>&1
                echo -e "\e[1;32mXong!\e[0m"
            done
            adb shell rm -rf /sdcard/Android/data/com.xiaomi.mitv.advertise
            echo -e "\e[1;32m✅ Đã quét sạch rác! Tivi mướt rượt rồi.\e[0m"
            sleep 3 ;;
        x|X) rm -f *.apk && exit 0 ;;
        *) echo "Sai rồi con vợ!" && sleep 1 ;;
    esac
done
