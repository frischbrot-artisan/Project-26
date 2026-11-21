# LWCloneU2 Resurrected

LED-Wiz™-compatible output controllers and input boards for virtual pinball and arcade cabinets.
Based on the LWCloneU2 firmware by Andreas Dittrich, with many extensions. Works with
DirectOutput Framework (DOF), LEDBlinky, Visual Pinball, MAME and any other program that uses `ledwiz.dll`.

Current version: **Rev 0.4b**

## 📦 Downloads

**All downloads are on the [Releases](https://github.com/frischbrot-artisan/Project-26/releases) page.**
Open the latest release and look under **Assets**.

You don't need to build anything yourself. The ready-to-flash HEX files for all boards are attached to every release.

## Boards

| Board | Based on | Outputs | Inputs |
|---|---|---|---|
| **DUO** | Arduino Pro Micro (ATmega32U4) | 8 × MOSFET (5 A) + 8 × ULN2803 (0.5 A) | – |
| **SLIM** | Arduino Pro Micro | 16 × ULN2803 | – |
| **FORCE** | Arduino Pro Micro | 16 × MOSFET | – |
| **VPINBALL** | Arduino Mega 2560 R3 (with ATmega16U2) | 16 × MOSFET + 16 × ULN2803 | 32 buttons + accelerometer (nudging) |
| **ARCADE** | Arduino Mega 2560 R3 (with ATmega16U2) | 32 × ULN2803 | 32 buttons (MAME default keys, 2 players) |
| **ROTORR** | Arduino Pro Micro | – | 2 trackballs + 2 spinners (appear as 4 USB mice) |
| **VERSUS** | Arduino Pro Micro | – | 32 buttons for 2 players (USB keyboard, MAME default keys) |

ROTORR and VERSUS are not LED-Wiz devices. DOF and LEDBlinky ignore them.

## HEX files

| Board | File(s) |
|---|---|
| DUO | `LWCloneU2_Resurrected_DUO_Rev0.4b.hex` |
| SLIM | `LWCloneU2_Resurrected_SLIM_Rev0.4b.hex` |
| FORCE | `LWCloneU2_Resurrected_FORCE_Rev0.4b.hex` |
| VPINBALL | `LWCloneU2_Resurrected_VPINBALL_Rev0.4b_ATmega2560.hex` + `…_ATmega16U2.hex` |
| ARCADE | `LWCloneU2_Resurrected_ARCADE_Rev0.4b_ATmega2560.hex` + `…_ATmega16U2.hex` |
| ROTORR | `ROTORR_Rev0.4b.hex` |
| VERSUS | `LWCloneU2_Resurrected_VERSUS_Rev0.4b.hex` |

The Mega boards need two files: one for the ATmega2560 and one for the ATmega16U2 USB chip.

## What's new compared to the original LWCloneU2

- **Bootloader via USB:** once this firmware is on the board, the tool starts the bootloader by itself. The reset button (Pro Micro boards) is only needed for the very first flash.
- **Safety shutdown:** all outputs switch off when the PC suspends the USB port (standby or shutdown).
- **Coil protection:** an adjustable maximum on-time for selected outputs, stored in EEPROM. Solenoids and motors survive a crashed or frozen program.
- **Adjustable PWM frequency.**
- **Board name in the USB device name**, so the tool detects the board automatically. DOF and other programs are not affected.
- **Accelerometer as its own gamepad** (VPINBALL). It no longer conflicts with the joystick 2 directions.
- **Shift button** on ARCADE and VERSUS: P1 START doubles as shift, so no extra button is needed.

## Flashing and configuration

The **LWCloneU2 Resurrected Tool** (Windows 7–11, .NET Framework 4) does the following:

- flashes the firmware for all boards
- sets the LED-Wiz ID
- configures coil protection and PWM frequency
- tests the accelerometer
- tests every output and input

The tool is available in English, German, French and Spanish.

To flash, put the HEX files from the release into the tool's `firmware` folder and use the **Flash firmware** tab.
The manuals and flash guides explain each step.

## Firmware source

The firmware source for all boards is in this repository. GitHub Actions builds every HEX file in one run, and the results are attached to the releases.

## Credits

- **LWCloneU2** firmware: Andreas Dittrich (cithraidt) – https://github.com/cithraidt/lwcloneu2
- **LUFA** USB library: Dean Camera – https://www.lufa-lib.org
- **ledwiz.dll** (32/64-bit): Mike Roberts (mjrgh) – https://github.com/mjrgh/lwcloneu2
- Board designs, firmware extensions, LWCloneU2 Resurrected Tool and manuals: Frischbrot, 2026

## License

The firmware, the tool and `ledwiz.dll` are licensed under **GPL-2.0**. See `LICENSE.txt`.

## Trademarks

LED-Wiz™ is a trademark of GroovyGameGear. Arduino® is a registered trademark of Arduino SA. MAME® is a registered trademark of Gregory Ember.
Ultimarc and SpinTrak are trademarks of Ultimarc. All other names are the property of their respective owners.
This project is not affiliated with or endorsed by any of them. These boards are *compatible with* the products named above. They are not those products.
