:: Delete any builds that have been made.
:: This is the nuclear option, bootstrap.sh (or cmake manually) must be
:: run after this.
:: This script won't touch the external expanded tarballs,
:: if you need to clean those, do it manually.

@ECHO OFF

if exist %~dp0build (
   echo Cleaning all builds...
   rmdir /S /Q %~dp0build
)

