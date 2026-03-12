#!/bin/bash

# Конфигурация
ml4w_cache_folder="$HOME/.config/ml4w/cache"
cachefile="$ml4w_cache_folder/current_wallpaper"
blurredwallpaper="$ml4w_cache_folder/blurred_wallpaper.png"
squarewallpaper="$ml4w_cache_folder/square_wallpaper.png"
rasifile="$ml4w_cache_folder/current_wallpaper.rasi"
blurfile="$HOME/.config/ml4w/settings/blur.sh"
defaultwallpaper="$HOME/.config/ml4w/wallpapers/default.jpg"
wallpapereffect="$HOME/.config/ml4w/settings/wallpaper-effect.sh"
generatedversions="$ml4w_cache_folder/wallpaper-generated"
waypaperrunning="$ml4w_cache_folder/waypaper-running"
hyprpanel_config="$HOME/.config/hyprpanel/config.json"

# Эффект по умолчанию
effect="${effect:-none}"

# Принудительная генерация отключена по умолчанию
force_generate=0


# Проверка блокировки — если waypaper запущен, завершаем
if [ -f "$waypaperrunning" ]; then
    rm -f "$waypaperrunning"
    exit 0
fi

# Создание папок
mkdir -p "$ml4w_cache_folder" "$generatedversions"

# Проверка кэша обоев
if [ -f ~/.config/ml4w/settings/wallpaper_cache ]; then
    use_cache=1
    echo ":: Using Wallpaper Cache"
else
    use_cache=0
    echo ":: Wallpaper Cache disabled"
fi

# Определение обоев
if [ -z "$1" ]; then
    if [ -f "$cachefile" ]; then
        wallpaper=$(cat "$cachefile")
    else
        wallpaper="$defaultwallpaper"
    fi
else
    wallpaper="$1"
fi
used_wallpaper="$wallpaper"
echo ":: Setting wallpaper with source image $wallpaper"

# Запись пути в кэш
echo "$wallpaper" > "$cachefile"

# Имя файла обоев
wallpaperfilename=$(basename "$wallpaper")
echo ":: Wallpaper Filename: $wallpaperfilename"

# Чтение значения размытия
if [ -f "$blurfile" ]; then
    blur=$(cat "$blurfile")
else
    blur="50x30"
fi

# Остановка waybar
echo ":: Stop all running waybar instances"
pkill -f waybar 2>/dev/null || true

# Запуск matugen
echo ":: Execute matugen with $used_wallpaper"
matugen image "$used_wallpaper" -m dark -t scheme-neutral

# Запуск pywal
echo ":: Execute pywal with $used_wallpaper"
wal -q -i "$used_wallpaper" || { echo "Error: pywal failed"; exit 1; }
source "$HOME/.cache/wal/colors.sh"

# Обновление pywalfox, если установлен
if type pywalfox >/dev/null 2>&1; then
    pywalfox update
fi

# Генерация размытого обоев
blur_cache="$generatedversions/blur-$blur-$effect-$wallpaperfilename.png"
if [ -f "$blur_cache" ] && [ "$force_generate" = "0" ] && [ "$use_cache" = "1" ]; then
    echo ":: Use cached wallpaper $blur_cache"
    cp "$blur_cache" "$blurredwallpaper"
else
    echo ":: Generate new cached wallpaper $blur_cache with blur $blur"
    notify-send --replace-id=1 "Generate new blurred version" "with blur $blur" -h int:value:66
    if [ "$blur" = "0x0" ]; then
        magick "$used_wallpaper" -resize 75% "$blurredwallpaper" || { echo "Error: magick resize failed"; exit 1; }
    else
        magick "$used_wallpaper" -resize 75% -blur "$blur" "$blurredwallpaper" || { echo "Error: magick blur failed"; exit 1; }
    fi
    cp "$blurredwallpaper" "$blur_cache"
fi

# Создание rasi файла
echo "* { current-image: url(\"$blurredwallpaper\", height); }" > "$rasifile"

# wal-telegram
sleep 1
wal-telegram --wal
wal-telegram --background "$wallpaper"
wal-telegram -r

# Квадратные обои
square_cache="$generatedversions/square-$wallpaperfilename.png"
magick "$used_wallpaper" -gravity Center -extent 1:1 "$squarewallpaper" || { echo "Error: square wallpaper failed"; exit 1; }
cp "$squarewallpaper" "$square_cache"

# Обновляем путь к обоям и включаем авто-генерацию в конфиге Hyprpanel
if [ -f "$hyprpanel_config" ]; then
    # Создаём резервную копию
    cp "$hyprpanel_config" "$hyprpanel_config.bak"
    
    if command -v jq &>/dev/null; then
        # Обновляем оба поля: путь к обоям И включаем генерацию
        jq --arg wp "$used_wallpaper" \
           '.wallpaper.image = $wp | .wallpaper.enable = true' \
           "$hyprpanel_config" > "$hyprpanel_config.tmp"
        mv "$hyprpanel_config.tmp" "$hyprpanel_config"
        echo ":: Updated Hyprpanel: wallpaper=$used_wallpaper, enable=true"
    else
        # Fallback через sed (менее надёжно)
        sed -i "s|\"wallpaper.image\": \".*\"|\"wallpaper.image\": \"$used_wallpaper\"|" "$hyprpanel_config"
        sed -i "s|\"wallpaper.enable\": .*|\"wallpaper.enable\": true|" "$hyprpanel_config"
        echo ":: Updated Hyprpanel wallpaper path using sed"
    fi
    
    # Перезапускаем Hyprpanel для применения
    sleep 0.5
    hyprpanel -q 2>/dev/null || true && hyprpanel &
    echo ":: Restarted Hyprpanel to apply new wallpaper"
else
    echo ":: Warning: Hyprpanel config not found at $hyprpanel_config"
fi

# Обновление цветов kitty
kitty @ set-colors --all --configured ~/.cache/wal/colors-kitty.conf
