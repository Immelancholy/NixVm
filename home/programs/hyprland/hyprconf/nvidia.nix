{
  wayland.windowManager.hyprland.extraConfig = ''
    env = LIBVA_DRIVER_NAME,nvidia
    env = __GLX_VENDOR_LIBRARY_NAME,nvidia
    env = __GL_VRR_ALLOWED,1
    #env = WLR_DRM_NO_ATOMIC,1
    env = GBM_BACKEND,nvidia-drm
    env = NVD_BACKEND,direct

    cursor:no_hardware_cursors = true
  '';
}
