#!/bin/bash
#hyprctl clients | grep -E "class:|initialTitle:|monitor:" | awk '{$1=""; print $0}' | paste - - - | awk '{class=($2 ? $2 : "-"); title=($4 ? $4 : "-"); monitor=($1 ? $1 : "-"); printf "%-25s %-20.20s %-7s\n", class, title, monitor}' | awk 'BEGIN {print "CLASS                     INITIAL TITLE         MONITOR"; print "------------------------- -------------------- -------"} {print}'

# Простой вывод списком
show_simple_list() {
    echo "=== АКТИВНЫЕ ОКНА HYPRLAND ==="
    echo ""
    
    # Используем JSON если есть jq
    if command -v jq &> /dev/null; then
        hyprctl clients -j | jq -r '.[] | "[\(.workspace.id)] \(.class) → \(.title)"' 2>/dev/null | while read -r line; do
            echo "$line"
        done
    else
        # Резервный парсер без jq
        hyprctl clients | while read -r line; do
            case "$line" in
                *"workspace:"*)
                    ws=$(echo "$line" | awk '{print $2}' | cut -d'(' -f1)
                    ;;
                *"class:"*)
                    class=$(echo "$line" | cut -d':' -f2- | sed 's/^[[:space:]]*//')
                    ;;
                *"initialTitle:"*)
                    title=$(echo "$line" | cut -d':' -f2- | sed 's/^[[:space:]]*//')
                    if [ -n "$class" ]; then
                        echo "[$ws] $class → $title"
                        class=""
                    fi
                    ;;
            esac
        done
    fi
    
    echo ""
    echo "Всего окон: $(hyprctl clients | grep -c "class:")"
}

# Альтернативный вариант с более детальной информацией
show_detailed_list() {
    echo "═══════════════════════════════════════════════════════════════════════════════"
    echo "  WS  КЛАСС                          ЗАГОЛОВОК"
    echo "═══════════════════════════════════════════════════════════════════════════════"
    
    if command -v jq &> /dev/null; then
        hyprctl clients -j | jq -r '.[] | "  \(.workspace.id)   \(.class) │ \(.title)"' 2>/dev/null | while IFS='│' read -r class title; do
            # Убираем лишние пробелы
            class=$(echo "$class" | sed 's/^[[:space:]]*//')
            title=$(echo "$title" | sed 's/^[[:space:]]*//')
            printf "  %-3s %-30s %s\n" "$ws" "$class" "$title"
        done
    else
        # Простой построчный вывод
        hyprctl clients | grep -E "workspace:|class:|initialTitle:" | \
        awk '{print $0}' | \
        while read -r line; do
            if [[ "$line" == *"workspace:"* ]]; then
                ws=$(echo "$line" | awk '{print $2}' | cut -d'(' -f1)
            elif [[ "$line" == *"class:"* ]]; then
                class=$(echo "$line" | cut -d':' -f2- | sed 's/^[[:space:]]*//')
            elif [[ "$line" == *"initialTitle:"* ]]; then
                title=$(echo "$line" | cut -d':' -f2- | sed 's/^[[:space:]]*//')
                printf "  %-3s %-30s %s\n" "$ws" "$class" "$title"
            fi
        done
    fi
    
    echo "═══════════════════════════════════════════════════════════════════════════════"
    echo "Всего окон: $(hyprctl clients | grep -c "class:")"
}

# Самый простой вариант
show_minimal_list() {
    if command -v jq &> /dev/null; then
        hyprctl clients -j | jq -r '.[] | "\(.workspace.id) | \(.class) | \(.title)"' 2>/dev/null
    else
        hyprctl clients | grep -E "workspace:|class:|initialTitle:" | \
        awk '{print $2}' | \
        paste -d '|' - - - | \
        sed 's/([^)]*)//g'
    fi
}

# Выбираем вариант
case "$1" in
    "-d"|"--detailed")
        show_detailed_list
        ;;
    "-m"|"--minimal")
        show_minimal_list
        ;;
    *)
        show_simple_list
        ;;
esac