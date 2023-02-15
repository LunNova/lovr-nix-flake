{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
  };

  outputs = flakeArgs@{ self, ... }:
    let
      lib = flakeArgs.nixpkgs.lib;
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
    in
    {
      packages = lib.genAttrs supportedSystems
        (system:
          let
            pkgs = flakeArgs.nixpkgs.legacyPackages.${system};
            self = {
              lovr = pkgs.callPackage ./pkgs/lovr.nix { };
              lovr-all-plugins = pkgs.callPackage ./pkgs/lovr-plugged.nix {
                inherit (self) lovr;
                plugins = with self; [
                  # lua-deepspeech # FIXME: doesn't build
                  lua-libsodium
                  luv
                ];
              };
              lua-deepspeech = pkgs.callPackage ./pkgs/lua-deepspeech.nix { };
              lua-libsodium = pkgs.callPackage ./pkgs/lua-libsodium.nix { };
              luv = pkgs.callPackage ./pkgs/luv.nix { };
            };
          in
          self);
    };
}
