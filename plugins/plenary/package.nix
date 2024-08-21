{ vimUtils, fetchFromGitHub, lib }:
let
  version = "0.1.4";
in
vimUtils.buildVimPlugin {
  inherit version;
  name = "plenary.nvim";

  src = fetchFromGitHub {
    owner = "nvim-lua";
    repo = "plenary.nvim";
    rev = "v${version}";
    hash = "sha256-zR44d9MowLG1lIbvrRaFTpO/HXKKrO6lbtZfvvTdx+o=";
  };
}
