{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      env = XDG_CURRENT_DESKTOP,Hyprland
      env = XDG_SESSION_TYPE,wayland
      env = XDG_SESSION_DESKTOP,Hyprland
      env = QT_QPA_PLATFORM,wayland;xcb
      env = QT_WAYLAND_DISABLE_WINDOWDECORATION,1
      env = QT_AUTO_SCREEN_SCALE_FACTOR,1
      env = MOZ_ENABLE_WAYLAND,1
      env = GDK_SCALE,1
      env = GRIMBLAST_EDITOR,swappy
    '';
  };
}
