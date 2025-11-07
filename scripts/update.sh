#!/bin/bash

# --- 1. Определяем ID genmon ---
for path in $(xfconf-query -c xfce4-panel -l | grep '/plugins/plugin-[0-9]\+$'); do
    type=$(xfconf-query -c xfce4-panel -p "$path" 2>/dev/null)
    if [[ "$type" == "genmon" ]]; then
        plugin_id=$(echo "$path" | grep -oE '[0-9]+$')
        break
    fi
done

if [[ -z "$plugin_id" ]]; then
    notify-send "Genmon не найден" "Не удалось определить ID плагина панели XFCE"
    exit 1
fi

# --- 2. Создаём временный скрипт ---
tmp=$(mktemp /tmp/update_XXXXXX.sh)
cat > "$tmp" <<'EOF'
#!/bin/bash
sudo pacman -Syu
status=$?
echo
if [[ $status -eq 0 ]]; then
    echo "✅ Обновление завершено успешно!"
else
    echo "⚠️ Ошибка при обновлении (код $status)"
fi
echo
read -p "Нажмите Enter для закрытия..."
EOF
chmod +x "$tmp"

# --- 3. Запускаем терминал в foreground ---
xfce4-terminal --disable-server --command "$tmp"

# --- 4. Ждём закрытия ---
wait

# --- 5. Уведомление и refresh ---
notify-send "Обновление завершено"
xfce4-panel --plugin-event=genmon-"$plugin_id":refresh:bool:true

# --- 6. Чистим за собой ---
rm -f "$tmp"
