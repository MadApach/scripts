#!/bin/bash

name=$(basename "$0")

# Проверяем аргументы
if [ $# -eq 0 ]; then
  cat << EOF
Usage: ${name} <шаблон_файлов>...

Примеры:
  ${name}                           # все *.mp4
  ${name} 1.avi                     # один файл
  ${name} "*.avi" "*.mpg"           # несколько масок
  ${name} "event_*_2003.mpg"        # конкретный паттерн

Конвертирует в H.265 (CRF 25, ~×2.5 сжатие)
EOF
  exit 1
fi

for file in "$@"; do
  # Пропускаем не-файлы (маски без совпадений)
  [ -f "$file" ] || continue  length=$(ffprobe -v quiet -show_entries format=duration -of csv=p=0 "$file" | awk '{print int($1)}')
  hours=$((length/3600))
  mins=$(((length%3600)/60))
  secs=$((length%60))

  echo ""
  echo "<====================================================>"
  echo ""
  echo "📹 Файл: ${file}"
  echo "⏱️  Длительность: ${hours}:${mins}:${secs}"
  echo ""

  output="${file%.*}_h265.mp4"
# like VLC
#   ffmpeg -loglevel warning -hide_banner -stats \
#     -i "$file" \
#     -c:v libx265 -b:v 4500k -maxrate 6000k -bufsize 9000k -preset fast \
#     -c:a mp2 -b:a 128k -ar 44100 -r 29.658 \
#     -movflags +faststart \
#     "$output" && \
#   echo "✓ $output ($(du -h "$output" | cut -f1))"
   /usr/bin/time -f "\n⏱️  Время: %E (%P CPU)\n" ffmpeg -loglevel info -hide_banner -stats \
    -i "$file" \
    -c:v libx265 -crf 25 -preset fast -b:v 5500k \
    -c:a mp2 -b:a 128k \
    "$output" && \
  echo "✓ $output ($(du -h "$output" | cut -f1))"
done
