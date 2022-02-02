{
  description = "Jono's flakes";

  inputs = {
    nixpkgs.url = github:NixOS/nixpkgs/nixos-21.11;
  };

  outputs = { self, nixpkgs }@attrs: {

    packages.x86_64-linux =
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      child-inputs = (import nixpkgs { system = "x86_64-linux"; }) // attrs;
      waterfox = import ./waterfox.nix child-inputs;
    in
    {
      inherit waterfox;
    };
  };
}
