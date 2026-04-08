_: {
  # Power management. Conflicts with power-profiles-daemon, which is not
  # enabled here (XFCE uses xfce4-power-manager and that coexists with TLP).
  services.tlp = {
    enable = true;
    settings = {
      # Governors and energy/perf bias.
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_BOOST_ON_AC = 1;
      CPU_BOOST_ON_BAT = 0;

      # ThinkPad firmware platform profile (fan curve, thermal headroom).
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";

      # Battery longevity: keep BAT0 between 75% and 80% on AC.
      # Lenovo-specific thresholds; harmless on non-ThinkPad batteries.
      START_CHARGE_THRESH_BAT0 = 75;
      STOP_CHARGE_THRESH_BAT0 = 80;

      # Aggressive runtime PM for PCIe / USB autosuspend.
      RUNTIME_PM_ON_AC = "auto";
      RUNTIME_PM_ON_BAT = "auto";

      # Wi-Fi power save only on battery.
      WIFI_PWR_ON_AC = "off";
      WIFI_PWR_ON_BAT = "on";
    };
  };

  # ThinkPad TrackPoint: enable kernel module + sane defaults.
  hardware.trackpoint = {
    enable = true;
    speed = 120;
    sensitivity = 200;
    emulateWheel = true;
  };

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
