_: {
  # Power management. Conflicts with power-profiles-daemon, which is not
  # enabled here (XFCE uses xfce4-power-manager and that coexists with TLP).
  services.tlp.enable = true;

  # Intel thermal management daemon.
  services.thermald.enable = true;

  # LVFS firmware updates (BIOS/EC) for ThinkPad.
  services.fwupd.enable = true;

  # Periodic TRIM for NVMe.
  services.fstrim.enable = true;

  # Compressed swap-in-RAM, easier on memory pressure than disk swap.
  zramSwap.enable = true;

  # Backlight CLI (`light -A 5`) + udev rules; user must be in the `video` group.
  programs.light.enable = true;
}
