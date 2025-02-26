{
  wayland.windowManager.hyprland.extraConfig = ''
    layerrule = noanim, hyprpicker
    layerrule = noanim, selection

    animations {
        enabled = yes
        bezier = wind, 0.05, 0.9, 0.1, 1.05
        bezier = winIn, 0.1, 1.1, 0.1, 1.1
        bezier = winOut, 0.3, -0.3, 0, 1
        bezier = liner, 1, 1, 1, 1
        animation = windows, 1, 6, wind, slide
        animation = windowsIn, 1, 6, winIn, slide
        animation = windowsOut, 1, 5, winOut, slide
        animation = windowsMove, 1, 5, wind, slide
        animation = border, 1, 1, liner
        animation = borderangle, 1, 35, liner, loop
        animation = fade, 1, 10, default
        animation = workspaces, 1, 5, wind
        animation = specialWorkspace, 1, 5, wind, slidevert
    }
  '';
}
