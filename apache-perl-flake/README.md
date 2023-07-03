# Notes for This Example

* Apache HTTPD is bundled with Perl + mod_perl as a single package in `apache-perl/flake.nix`. See that file for more details on how the flake is built.
* The Devbox Apache plugin is manually added in the `include` section of `devbox.json`
* Because the default apache plugin service is not compatible with the flake, I've added a process-compose.yaml in this directory that overrides it. We can probably update the built-in plugin so that this step isn't necessary
