{
  description = "NixVim config heavily inspired by AstroNvim";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Nix formatting pack
    # https://gerschtli.github.io/nix-formatter-pack/nix-formatter-pack-options.html
    nix-formatter-pack = {
      url = "github:Gerschtli/nix-formatter-pack";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim/main";
      #inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { nixpkgs
    , nixvim
    , nix-formatter-pack
    , ...
    }:
    let
      forAllSystems = nixpkgs.lib.genAttrs [
        "aarch64-linux"
        "i686-linux"
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];
    in
    {
      formatter = forAllSystems (system:
        nix-formatter-pack.lib.mkFormatter {
          pkgs = nixpkgs.legacyPackages.${system};

          config.tools = {
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        }
      );

      packages = forAllSystems (system:
        let
          pkgs = import nixpkgs { 
            inherit system; 
            overlays = [ (final: prev: {
              # Force ccls to work with xtensa (Supported in libllvm 20 based deps)
              ccls = prev.ccls.overrideAttrs (_: prevAttrs: {
                src = prev.fetchFromGitHub {
                  owner = "MaskRay";
                  repo = "ccls";
                  rev = "master";
                  hash = "sha256-OgdvY/F0sBVNEFDBDm3GK2QYRYeez1qiW8MuP+Yn7LI=";
                };
                /* src = prev.fetchFromGitHub {
                  owner = "Redrield";
                  repo = "ccls";
                  rev = "fix/host-triple-when-unknown";
                  hash = "sha256-M2/SDpcQvZfoGE+2Y/pfj5ma5Cog/BQwrN+BDGpXqcY=";
                }; */

                buildInputs = with prev.llvmPackages_20; [ libclang llvm prev.rapidjson ];
                nativeBuildInputs = [ prev.cmake prev.llvmPackages_20.llvm.dev ];
                clang = prev.llvmPackages_20.clang;

                #patches = [ ./ccls.patch ];
              });
            }) ];
          };
          mkNixvim = specialArgs:
            nixvim.legacyPackages.${system}.makeNixvimWithModule {
              inherit pkgs;

              module = ./.;

              extraSpecialArgs = specialArgs // {
                inherit pkgs;

                icons = import ./utils/_icons.nix;
              };
            };
        in
        {
          default = mkNixvim { };
          lite = mkNixvim { withLSP = false; };
        }
      );
    };
}
