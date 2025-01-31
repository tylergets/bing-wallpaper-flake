{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: {
    packages = {
      x86_64-linux = {
        hello = nixpkgs.legacyPackages.x86_64-linux.hello;
        default = self.packages.x86_64-linux.hello;
        image = let
          imageData = builtins.fromJSON (builtins.readFile ./image_data.json);
        in nixpkgs.legacyPackages.x86_64-linux.fetchurl {
          url = imageData.image_url;
          sha256 = imageData.sha256;
        };
      };
    };
  };
}
