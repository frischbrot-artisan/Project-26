# LWCloneU2 Resurrected Rev 0.4b – HEX-Dateien bauen (nur für Entwickler)

Nur für Entwickler. Endnutzer bauen keine HEX-Dateien, sondern laden sie fertig von GitHub (github.com/frischbrot-artisan/Project-26/releases).
Die hier gebauten Dateien werden dort als Release veröffentlicht (HEX-Bau-Anleitung, Kapitel 8).

Ein Durchlauf baut die HEX-Dateien **aller** Boards:

| Board | HEX-Datei(en) |
|---|---|
| DUO, SLIM, FORCE (Pro Micro) | `LWCloneU2_Resurrected_DUO_Rev0.4b.hex`, `…_SLIM_Rev0.4b.hex`, `…_FORCE_Rev0.4b.hex` |
| ROTORR (Pro Micro) | `ROTORR_Rev0.4b.hex` |
| VERSUS (Pro Micro) | `LWCloneU2_Resurrected_VERSUS_Rev0.4b.hex` |
| VPINBALL (Arduino Mega 2560) | `LWCloneU2_Resurrected_VPINBALL_Rev0.4b_ATmega2560.hex`, `…_ATmega16U2.hex` |
| ARCADE (Arduino Mega 2560) | `LWCloneU2_Resurrected_ARCADE_Rev0.4b_ATmega2560.hex`, `…_ATmega16U2.hex` |

## So geht's (ausführlich: HEX-Bau-Anleitung im Ordner `anleitungen`)

1. Auf github.com ein neues **öffentliches** Repository anlegen (ohne README), damit die Endnutzer die Releases laden können.
2. „uploading an existing file“ → `build_hex.sh`, `source_firmware.zip` (**nicht entpacken**) und `README.md` hineinziehen
   (bei einem öffentlichen Repository zusätzlich `LICENSE.txt` aus dem Hauptordner der Komplett-Datei) → **Commit changes**.
3. **Add file → Create new file**, Name `.github/workflows/build.yml`, Inhalt aus `build.yml (Inhalt fuer .github-workflows).txt` einfügen → **Commit changes**.
4. Reiter **Actions**: Der Lauf „HEX-Dateien bauen“ startet von selbst (ca. 3 min).
5. Lauf anklicken → unten **Artifacts**: jede HEX-Datei steht dort einzeln (ohne ZIP) → herunterladen, prüfen und als Release veröffentlichen (Releases → Create a new release → Dateien anhängen → Publish release).

Ein älteres Repository für ein einzelnes Board-System (z. B. mit `source_vpinball.zip`) lässt sich weiterverwenden: `build_hex.sh`
ersetzen und `source_firmware.zip` hochladen.

Lokal unter Linux/WSL: `sudo apt install gcc-avr avr-libc binutils-avr make unzip`, dann `sh build_hex.sh` (Ergebnis im Ordner `hex`).

## Herkunft

Firmware-Grundlage LWCloneU2: Andreas Dittrich – https://github.com/cithraidt/lwcloneu2 ·
USB-Bibliothek LUFA: Dean Camera – https://www.lufa-lib.org ·
AVR-Compiler: GNU-Projekt / avr-libc (installiert der Workflow) · GitHub Actions: https://github.com/actions
