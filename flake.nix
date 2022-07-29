{
  description = "Kiri's NixOS configuration";

  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    supportedSystems = ["x86_64-linux"];

    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    nixpkgsFor = forAllSystems (system: import nixpkgs {inherit system;});
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.stylua;
    devShell = forAllSystems (
      system: let
        pkgs = nixpkgsFor.${system};
      in
        pkgs.mkShell
        {
          buildInputs = with pkgs; [
            sumneko-lua-language-server
            stylua
          ];
        }
    );
  };
}
