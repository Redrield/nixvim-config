{ vimUtils, fetchFromGitHub, lib, ... }:
vimUtils.buildVimPlugin rec {
  name = "vim-flog";
  version = "3.0.0";

  src = fetchFromGitHub {
    owner = "rbong";
    repo = name;
    rev = "v${version}";
    hash = "sha256-A3KQlYiLnrP1w0EUZ1UaiyxXqNKITrVlRbtSNFFsYFI=";
  };
}
