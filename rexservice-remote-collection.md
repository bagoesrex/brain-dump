# RexService Remote Collection

## Main Tools

- [MainTools](https://drive.google.com/file/d/1nqSZKjMvcJeGgEussVna-1TGw6bEkacU/view?usp=drive_link) - Remote desktop alternatif AnyDesk/TeamViewer yang ringan.

## Remote Desktop & USB Passthrough

- [UltraViewer](https://www.ultraviewer.net/en/download.html/) - Remote desktop alternatif AnyDesk/TeamViewer yang ringan.

## Driver Esensial Client

- [MediaTek VCOM USB Drivers](https://androidmtk.com/download-mtk-usb-vcom-driver) - Driver preloader/BROM MediaTek.
- [Qualcomm QDLoader 9008 Driver](https://androidfilehost.com/?w=files&flid=305436) - Driver mode EDL Qualcomm 32/64 bit.
- [Samsung USB Driver](https://developer.samsung.com/android-usb-driver) - Driver resmi ADB & Odin Samsung.
- [Fastboot & ADB (Platform Tools)](https://developer.android.com/tools/releases/platform-tools) - Google official binaries.
- [UsbDk](https://github.com/daynix/UsbDk/releases) - Controller level USB capture (dibutuhkan MTK Client / exploit BROM).
- [libusb-win32 filter installer](https://sourceforge.net/projects/libusb-win32/) - Filter driver untuk BROM bypass / Mediatek payload.

## Flashing & Brand Specific Tools

### Qualcomm
- [QFIL / QPST](https://qpsttool.com/) - Tool official Qualcomm untuk flash firehose rawprogram/patch.
- [Mi Flash Tool](https://xiaomiflashtool.com/) - Flashing fastboot ROM resmi Xiaomi Qualcomm.

### MediaTek
- [SP Flash Tool](https://spflashtool.com/) - Flashing scatter firmware MTK.
- [mtkclient](https://github.com/bkerler/mtkclient) - Open-source BROM exploit, dump boot, unlock bootloader, read/write partition.

### Samsung
- [Odin3](https://odindownload.com/) - Flashing tar.md5 Samsung official.
- [SamFW Tool](https://samfw.com/blog/samfw-frp-tool-download) - Tool all-in-one aktivasi ADB, test mode, FRP reset, change CSC.

### Unisoc / Spreadtrum
- [SPD Upgrade Tool / ResearchDownload](https://spdflashtool.com/) - Flashing firmware format .pac Unisoc/SPD.

## Root & Custom Recovery Resources

- [Magisk](https://github.com/topjohnwu/Magisk/releases) - Root solution standar.
- [KernelSU](https://github.com/tiann/KernelSU/releases) - Kernel-based root.
- [APatch](https://github.com/bmax121/APatch/releases) - Kernel-patching root alternatif Magisk/KSU.
- [TWRP Devices](https://twrp.me/Devices/) - Database resmi TWRP recovery.
- [OrangeFox Recovery](https://orangefox.download/) - Alternatif custom recovery modern.

## Firmware & ROM Sources

- [SamFW Firmwares](https://samfw.com/) - Download stock firmware Samsung cepat tanpa limit speed.
- [Xiaomi Firmware Updater](https://xiaomifirmwareupdater.com/) - Arsip Fastboot & Recovery ROM Xiaomi/Redmi/POCO.
- [Lolinet Mirrors](https://mirrors.lolinet.com/) - Arsip firmware Motorola, Lenovo, dan brand lainnya.
- [HalabTech Support](https://support.halabtech.com/) - Database firmware, cert, dan dump file teknisi.

## SOP & Checklists Singkat

- **Pre-Check**: Pastikan baterai minimal 50%, kabel original/data (bukan hanya charge), port USB belakang PC (bukan hub).
- **Setup Client**: Install driver yang sesuai -> Pasang USB Redirector (Client mode) -> Connect ke IP teknisi.
