# XFCE на Arch Linux: установка и базовая настройка

Набор базовых команд и шагов для установки и настройки XFCE на Arch Linux.
Подходит как для чистой системы, так и для тайловых WM (Hyprland, i3, bspwm и др.).

---

## Содержание

- [XFCE на Arch Linux: установка и базовая настройка](#xfce-на-arch-linux-установка-и-базовая-настройка)
  - [Содержание](#содержание)
  - [1. Быстрый старт](#1-быстрый-старт)
  - [2. Установка XFCE](#2-установка-xfce)
  - [3. Установка и активация дисплей-менеджера](#3-установка-и-активация-дисплей-менеджера)
  - [4. Системная локаль (русский язык)](#4-системная-локаль-русский-язык)
  - [5. Апплет сети](#5-апплет-сети)
  - [6. Звук (PipeWire)](#6-звук-pipewire)
  - [7. Оформление: темы, иконки, шрифты](#7-оформление-темы-иконки-шрифты)
  - [8. Менеджеры архивов](#8-менеджеры-архивов)
  - [9. Автомонтирование флешек и внешних дисков](#9-автомонтирование-флешек-и-внешних-дисков)
  - [10. Bluetooth](#10-bluetooth)
  - [11. Апплет обновлений системы](#11-апплет-обновлений-системы)

---

## 1. Быстрый старт

Краткое руководство: установите XFCE, настройте дисплей-менеджер и базовые компоненты системы.

---

## 2. Установка XFCE

```bash
sudo pacman -Syu
sudo pacman -S --needed xfce4 xfce4-goodies
```

---

## 3. Установка и активация дисплей-менеджера

```bash
sudo pacman -S lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
sudo systemctl enable --now lightdm
```

Перезагрузите систему.

**Компоненты:**

* `lightdm` — экранный менеджер
* `lightdm-gtk-greeter` — экран приветствия
* `lightdm-gtk-greeter-settings` — настройки оформления входа

---

## 4. Системная локаль (русский язык)

Проверьте доступные локали:

```bash
localectl list-locales
```

Если русская локаль отсутствует, отредактируйте:

```bash
sudo nano /etc/locale.gen
```

Найдите строку (Ctrl+F для поиска)

```
#ru_RU.UTF-8 UTF-8
```

Уберите `#` в начале строки, сохраните файл (`Ctrl+O`, `Enter`, `Ctrl+X`).

Сгенерируйте локали:
```bash
sudo locale-gen
```
Установите системную локаль:
```bash
sudo localectl set-locale LANG=ru_RU.UTF-8
```

(или вручную через `/etc/locale.conf`)

---

## 5. Апплет сети

Устанавливает индикатор сети (NetworkManager Applet) для панели XFCE:

```bash
sudo pacman -S network-manager-applet
```

---

## 6. Звук (PipeWire)

Современная замена PulseAudio. Решает проблему “Нет соединения с сервером звука”.

```bash
sudo pacman -S pipewire pipewire-alsa pipewire-pulse pipewire-jack wireplumber pavucontrol
```

Перезагрузите систему.

---

## 7. Оформление: темы, иконки, шрифты

Ресурс с темами и иконками: [xfce-look.org](https://xfce-look.org)

```bash
sudo pacman -S firefox noto-fonts
```

Папки для оформления:

```
~/.themes   → темы
~/.icons    → иконки и курсоры
~/.fonts    → шрифты (необязательно)
```

---

## 8. Менеджеры архивов

Выберите один вариант:

**Engrampa** (рекомендуется, MATE):

```bash
sudo pacman -S engrampa
```

**Альтернативы:**

```bash
sudo pacman -S xarchiver       # лёгкий
sudo pacman -S file-roller     # GNOME
sudo pacman -S ark             # KDE
```

---

## 9. Автомонтирование флешек и внешних дисков

```bash
sudo pacman -S gvfs gvfs-mtp gvfs-smb
```

**Компоненты:**

* `gvfs-mtp` — поддержка Android / MTP-устройств
* `gvfs-smb` — сетевые диски Windows

Для трея и уведомлений можно добавить:

```bash
sudo pacman -S udiskie
```

Добавить в автозапуск:
**Настройки → Сеансы и запуск → Автозагрузка → `udiskie -t`**

---

## 10. Bluetooth

```bash
sudo pacman -S bluez bluez-utils blueman
sudo systemctl enable --now bluetooth
```

После запуска появится иконка в трее.

---

## 11. Апплет обновлений системы

Клонируйте репозиторий:

```bash
cd /tmp
git clone https://github.com/linswitch/arch-xfce.git 
```

Скопируйте скрипты
```bash
cp -r arch-xfce/scripts ~/.config/
```
Добавьте на панель плагин **Общий монитор (Generic Monitor)**


**Настройки плагина:**

* Команда: `~/.config/scripts/check-updates.sh`
* Интервал: `3600` секунд (или по желанию)

Для работы требуется:

```bash
sudo pacman -S pacman-contrib
```

---

📺 Видео-гайд: [YouTube — Linswitch](https://www.youtube.com/@LinSwitch)
🐧 Автор: [Linswitch на GitHub](https://github.com/linswitch)

---

