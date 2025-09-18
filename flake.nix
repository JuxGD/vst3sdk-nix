{
  description = "The VST 3 SDK";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    jux-is-a-nix-maintainer-apparently.url = "git+https://codeberg.org/JuxGD/jux-is-a-nix-maintainer-apparently?ref=main";
  };

  outputs = { self, nixpkgs, jux-is-a-nix-maintainer-apparently, ... }@inputs: rec {
    packages.x86_64-linux.default = let
      vst3sdkthing = { stdenv, lib, fetchFromGitHub }: stdenv.mkDerivation {
        pname = "vst3sdk";
        version = "3.7.14";
        src = fetchFromGitHub {
          owner = "steinbergmedia";
          repo = "vst3sdk";
          rev = "v3.7.14_build_55";
          hash = "sha256-Tyh8InZhriRh2bP9YqaXoVv33CYlwro9mpBKmoPNTfU=";
          fetchSubmodules = true;
        };

        installPhase = ''
	  mkdir -p $out/lib
          cp -r $src $out/lib
        '';

        meta = {
          description = "The VST 3 SDK";
          longDescription = "steinberg you got nothing on me all i'm doing is cloning your repo LMAO try to sue me you can't LOLLLLLL";
          branch = "master";
          homepage = "https://www.steinberg.net/developers/";
          downloadPage = "https://github.com/steinbergmedia/vst3sdk/";
          maintainers = [
            inputs.jux-is-a-nix-maintainer-apparently.maintainers-list.JuxGD
          ];
          license = lib.licenses.mit;
          platforms = lib.platforms.linux;
          mainProgram = "saddle";
        };
      };
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in pkgs.callPackage vst3sdkthing { };
  };
}
