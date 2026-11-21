#!/bin/sh
# LWCloneU2 Resurrected Rev 0.4b - baut ALLE Firmware-HEX-Dateien und legt sie in den Ordner hex/:
#   DUO, SLIM, FORCE, VERSUS (Pro Micro), VPINBALL und ARCADE (Arduino Mega 2560: ATmega2560 + ATmega16U2)
#   sowie ROTORR (2 Trackbaelle + 2 Spinner, Pro Micro)
# Voraussetzung (Linux/WSL): sudo apt install gcc-avr avr-libc binutils-avr make unzip
set -e
REV=0.4b
ROOT="$(cd "$(dirname "$0")" && pwd)"
mkdir -p "$ROOT/hex"

# Quellcode: source_firmware.zip (GitHub-Weboberflaeche: max. 100 Dateien pro Upload) oder vorhandener Ordner source/
ZIP="$(find "$ROOT" -maxdepth 3 -name 'source_firmware.zip' -not -path '*/.git/*' | head -n 1)"
if [ -n "$ZIP" ]; then
  echo "Verwende $ZIP"
  rm -rf "$ROOT/source"
  unzip -q -o "$ZIP" -d "$ROOT"
elif [ -f "$ROOT/source/firmware/led.c" ]; then
  echo "Verwende den vorhandenen Ordner source/"
else
  echo "FEHLER: source_firmware.zip wurde nicht gefunden."
  echo "Bitte source_firmware.zip (NICHT entpackt) aus dem Ordner github der Komplett-Datei in den Hauptordner des Repositorys hochladen."
  echo "Inhalt des Repositorys:"
  find "$ROOT" -maxdepth 3 -not -path '*/.git*' | sed "s#$ROOT#.#" | sort
  exit 1
fi
FW="$ROOT/source/firmware"
for D in lwc_promicro_driver lwc_mega_driver lwc_arcade_driver rotorr_driver lwc_versus_driver; do
  if [ ! -d "$FW/$D" ]; then
    echo "FEHLER: In der ZIP-Datei fehlt source/firmware/$D - alte oder falsche source-ZIP?"
    echo "Bitte source_firmware.zip aus dem Ordner github der Komplett-Datei hochladen."
    exit 1
  fi
done

check_name() {   # $1 = HEX-Datei, $2 = erwarteter USB-Name
  avr-objcopy -I ihex -O binary "$1" "$ROOT/hex/.check.bin"
  if strings -el "$ROOT/hex/.check.bin" | grep -q "$2"; then echo "  USB-Name OK: \"$2\""; else echo "FEHLER: USB-Name \"$2\" nicht in $1 gefunden"; exit 1; fi
  rm -f "$ROOT/hex/.check.bin"
}

# ---------------------------------------------------------------- Pro Micro: DUO, SLIM, FORCE
cd "$FW/lwc_promicro_driver"
for V in DUO SLIM FORCE; do
  echo; echo "=== Baue LWCloneU2 Resurrected $V Rev $REV ==="
  make clean > /dev/null 2>&1 || true
  make all LWC_DEFS="-DLWC_BOARD_$V"
  avr-size --mcu=atmega32u4 -C lwc_promicro_driver.elf || true
  OUT="$ROOT/hex/LWCloneU2_Resurrected_${V}_Rev${REV}.hex"
  cp lwc_promicro_driver.hex "$OUT"
  check_name "$OUT" "LWCloneU2 Resurrected $V Rev $REV"
done

# ---------------------------------------------------------------- Pro Micro: ROTORR (2 Trackbaelle + 2 Spinner, 4 USB-Maeuse)
cd "$FW/rotorr_driver"
echo; echo "=== Baue ROTORR Rev $REV ==="
make clean > /dev/null 2>&1 || true
make all
avr-size --mcu=atmega32u4 -C rotorr.elf || true
OUT="$ROOT/hex/ROTORR_Rev${REV}.hex"
cp rotorr.hex "$OUT"
check_name "$OUT" "ROTORR Rev $REV"

# ---------------------------------------------------------------- Pro Micro: VERSUS (32 Taster, Tastatur mit N-Key-Rollover)
cd "$FW/lwc_versus_driver"
echo; echo "=== Baue LWCloneU2 Resurrected VERSUS Rev $REV ==="
make clean > /dev/null 2>&1 || true
make all
avr-size --mcu=atmega32u4 -C lwc_versus_driver.elf || true
OUT="$ROOT/hex/LWCloneU2_Resurrected_VERSUS_Rev${REV}.hex"
cp lwc_versus_driver.hex "$OUT"
check_name "$OUT" "LWCloneU2 Resurrected VERSUS Rev $REV"

# ---------------------------------------------------------------- Arduino Mega: VPINBALL, ARCADE
for BN in VPINBALL ARCADE; do
  if [ "$BN" = "ARCADE" ]; then DRV=lwc_arcade_driver; else DRV=lwc_mega_driver; fi
  cd "$FW/$DRV"
  echo; echo "=== Baue LWCloneU2 Resurrected $BN Rev $REV (ATmega2560 + ATmega16U2) ==="
  make all
  avr-size --mcu=atmega2560 -C m2560/${DRV}__m2560.elf || true
  avr-size --mcu=atmega16u2 -C m16u2/${DRV}__m16u2.elf || true
  cp m2560/${DRV}__m2560.hex "$ROOT/hex/LWCloneU2_Resurrected_${BN}_Rev${REV}_ATmega2560.hex"
  cp m16u2/${DRV}__m16u2.hex "$ROOT/hex/LWCloneU2_Resurrected_${BN}_Rev${REV}_ATmega16U2.hex"
  check_name "$ROOT/hex/LWCloneU2_Resurrected_${BN}_Rev${REV}_ATmega16U2.hex" "LWCloneU2 Resurrected $BN Rev $REV"
done
echo
ls -l "$ROOT/hex/"*.hex
