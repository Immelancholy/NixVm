# flake.nix
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    catppuccin.url = "github:catppuccin/nix";
    nixcord.url = "github:kaylorben/nixcord";
    home-manager = {
      url = "github:nix-community/home-manager";
      # The `follows` keyword in inputs is used for inheritance.
      # Here, `inputs.nixpkgs` of home-manager is kept consistent with
      # the `inputs.nixpkgs` of the current flake,
      # to avoid problems caused by different versions of nixpkgs.
      inputs.nixpkgs.follows = "nixpkgs";
    };
    solaar = {
      url = "https://flakehub.com/f/Svenum/Solaar-Flake/*.tar.gz"; # For latest stable version
      #url = "https://flakehub.com/f/Svenum/Solaar-Flake/0.1.1.tar.gz"; # uncomment line for solaar version 1.1.13
      #url = "github:Svenum/Solaar-Flake/main"; # Uncomment line for latest unstable version
      inputs.nixpkgs.follows = "nixpkgs";
    };
    yazi.url = "github:sxyazi/yazi";
    yazi-plugins = {
      url = "github:yazi-rs/plugins";
      flake = false;
    };
    yazi-flavors = {
      url = "github:yazi-rs/flavors";
      flake = false;
    };
    yamb = {
      url = "github:Immelancholy/yamb.yazi";
      flake = false;
    };
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    swww.url = "github:LGFae/swww";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";
    hyprtasking = {
      url = "github:raybbian/hyprtasking";
      inputs.hyprland.follows = "hyprland";
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.11";

      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    prismlauncher = {
      url = "github:PrismLauncher/PrismLauncher";
    };
    Hyprspace = {
      url = "github:KZDKM/Hyprspace";

      # Hyprspace uses latest Hyprland. We declare this to keep them in sync.
      inputs.hyprland.follows = "hyprland";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    stylix.url = "github:danth/stylix";
  };

  outputs = {
    self,
    nixpkgs,
    stylix,
    catppuccin,
    home-manager,
    solaar,
    rust-overlay,
    nix-flatpak,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    user = "";
    defaultpass = "password"; #(just leave this, if you want to change the password use mkpassword in the vm!)
    git = "";
    email = "";
    nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {inherit inputs user git email defaultpass;};
      modules = [
        ({pkgs, ...}: {
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = [rust-overlay.overlays.default];
          environment.systemPackages = with pkgs; [
            (
              rust-bin.selectLatestNightlyWith
              (toolchain:
                toolchain.default.override {
                  extensions = ["rust-src" "rust-analyzer"];
                })
            )
          ];
        })

        nix-flatpak.nixosModules.nix-flatpak
        solaar.nixosModules.default
        ./system
        ./virt.nix
        catppuccin.nixosModules.catppuccin

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            extraSpecialArgs = {inherit inputs user git email;};
          };

          # TODO replace ryan with your own username ;
          home-manager.users.${user} = {
            imports = [
              stylix.homeManagerModules.stylix
              ./home
              catppuccin.homeManagerModules.catppuccin
              inputs.nixcord.homeManagerModules.nixcord
              inputs.nixvim.homeManagerModules.nixvim
            ];
          };
          # Optionally, use home-manager.extraSpecialArgs to pass arguments to home.nix
        }
      ];
    };
  in {
    # test is a hostname for our machine. This is optional if you don't need
    # to also expose the NixOS configuration for other purposes.
    nixosConfigurations.nixos = nixos;

    # expose the build attribute directly
    vms.nixos = nixos.config.system.build.vm;
  };
}
