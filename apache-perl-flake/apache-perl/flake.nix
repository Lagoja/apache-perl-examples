{
  description = "A very basic flake";

  inputs = {
      nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
      flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils } :
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        # Make sure mod_perl builds against the right httpd and perl
        mod_perl = pkgs.apacheHttpdPackages.mod_perl.override { apacheHttpd = pkgs.apacheHttpd.out; perl = pkgs.perl.out;};
      in {
        # Bundle Apache, Perl, and mod_perl together in a single directory
        packages = with pkgs; rec {
          apache = symlinkJoin {
            name = "apache-with-perl";
            paths = [apacheHttpd perl mod_perl];
            nativeBuildInputs = [makeWrapper];
            # Wrap httpd so that we always load the perl_module
            postBuild = ''
              wrapProgram $out/bin/httpd --add-flags -C --add-flags "'LoadModule perl_module ${mod_perl}/modules/mod_perl.so'";
          '';
          };
          default = apache;
        };
      }
    );
}