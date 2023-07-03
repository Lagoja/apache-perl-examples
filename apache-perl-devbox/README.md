# Notes for This Example

This example uses Devbox to setup Apache with mod_perl without using a custom flake.

* This example requires two special env variables to work correctly
  * `APACHE_MOD_DIR` points to the location of `mod_perl.so` in the .wrappers/modules directory
  * `PERL5LIB` adds the required perl modules for `mod_perl` to Perl's `@INC` path.

* `mod_perl` is loaded in Apache by adding `LoadModule perl_module "${APACHE_MOD_DIR}/mod_perl.so"` to devbox.d/apache/httpd.conf