#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):103546880:a28272660950740c79b695ec528e665ffc9fd95a; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/bootdevice/by-name/boot$(getprop ro.boot.slot_suffix):100663296:9d37573c34ba13a4830e2091709f0b1b23494875 \
          --target EMMC:/dev/block/bootdevice/by-name/recovery$(getprop ro.boot.slot_suffix):103546880:a28272660950740c79b695ec528e665ffc9fd95a && \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (/vendor/bin/log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  /vendor/bin/log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi

