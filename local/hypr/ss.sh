#!/bin/bash

if [ "$1" == "area" ]; then
  # --region veya -s olmadan doğrudan slurp çıktısını argüman olarak veriyoruz
  geometry=$(slurp)
  # Eğer kullanıcı iptal ederse (boş dönerse) işlemi durdur
  if [ -z "$geometry" ]; then
    exit 0
  fi
  wayshot -g "$geometry" "$HOME/Pictures/ss-$(date +%s).png"
else
  wayshot "$HOME/Pictures/ss-$(date +%s).png"
fi

notify-send "Screenshot alındı" "Dosya kaydedildi."
