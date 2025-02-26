{
  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  virtualisation.vmVariant = {
    virtualisation.qemu.options = [
      "-machine type=q35"
      "-device virtio-vga"
      "-cpu host,topoext=on"
      "-m 8G,slots=2,maxmem=16G -smp 16,sockets=1,cores=8,threads=2,maxcpus=16"
      "-k en-gb"
      "-audio pipewire,model=virtio"
      "-chardev qemu-vdagent,id=ch1,name=vdagent,clipboard=on" 
      "-device virtio-serial-pci"
      "-device virtserialport,chardev=ch1,id=ch1,name=com.redhat.spice.0"
    ];
  };
}
