# 🕷️ Miles Morales SDDM Teması — Quraşdırma Bələdçisi

## Fayl Strukturu
```
/usr/share/sddm/themes/miles-morales/
├── Main.qml          ← əsas tema faylı
├── theme.conf        ← konfiqurasiya (fon şəklini buradan yazın)
├── metadata.desktop  ← SDDM tema metadatası
└── INSTALL.md        ← bu fayl
```

---

## 1. Tema qovluğunu kopyalayın

```bash
sudo cp -r miles-morales-sddm /usr/share/sddm/themes/miles-morales
sudo chown -R root:root /usr/share/sddm/themes/miles-morales
sudo chmod -R 755 /usr/share/sddm/themes/miles-morales
```

---

## 2. Fon şəklini əlavə edin

İstədiyiniz şəkli tema qovluğuna kopyalayın:

```bash
sudo cp /path/to/your/wallpaper.jpg /usr/share/sddm/themes/miles-morales/background.jpg
```

Sonra `theme.conf` faylında fon yolunu yazın:

```bash
sudo nano /usr/share/sddm/themes/miles-morales/theme.conf
```

```ini
[General]
background=/usr/share/sddm/themes/miles-morales/background.jpg
```

> 💡 **Tövsiyə olunan fon:** Miles Morales oyunundan qaranlıq Harlem şəhər mənzərəsi  
> və ya "Into the Spider-Verse" üslubu anime şəhər fonları.

---

## 3. SDDM konfiqurasiyasını yeniləyin

```bash
sudo mkdir -p /etc/sddm.conf.d
sudo nano /etc/sddm.conf.d/theme.conf
```

Aşağıdakını yazın:

```ini
[Theme]
Current=miles-morales
```

---

## 4. Temanı test edin (logout etmədən!)

### Qt6 üçün:
```bash
sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/miles-morales
```

### Qt5 üçün (köhnə sistemlər):
```bash
sddm-greeter --test-mode --theme /usr/share/sddm/themes/miles-morales
```

---

## 5. Asılılıqları yoxlayın

### Arch / Manjaro:
```bash
sudo pacman -S qt6-declarative qt6-quickcontrols2
```

### Ubuntu / Debian:
```bash
sudo apt install qml-module-qtquick-controls2 qml-module-qtquick-layouts
```

### Fedora:
```bash
sudo dnf install qt6-qtdeclarative qt6-qtquickcontrols2
```

---

## 6. metadata.desktop — Qt versiyasını uyğunlaşdırın

Sisteminizdə **Qt5** varsa, `metadata.desktop` faylında:
```ini
QtVersion=5
```
yazın.

**Qt6** üçün (standart, artıq belə yazılıb):
```ini
QtVersion=6
```

---

## Tez-tez Verilən Suallar

**S: Fon şəkli görünmür?**  
C: `theme.conf`-da tam yolu yazın: `/usr/share/sddm/themes/miles-morales/background.jpg`

**S: Tema tətbiq olunmur?**  
C: `/etc/sddm.conf.d/theme.conf`-da `Current=miles-morales` olduğunu yoxlayın.  
Qovluq adı `miles-morales` olmalıdır — başqa ad qoyulubsa, onu `Current=` hissəsində düzəldin.

**S: QML error görünür?**  
C: `sudo sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/miles-morales` ilə xətanı oxuyun.

**S: Sistem Qt5 işlədir amma Qt6 xətası verir?**  
C: `metadata.desktop` faylında `QtVersion=5` yazın.

---

## Sıfırlamaq istəyirsinizsə

```bash
sudo rm -rf /usr/share/sddm/themes/miles-morales
sudo rm /etc/sddm.conf.d/theme.conf
```

---

*"Anyone can wear the mask." — Miles Morales* 🕷️
