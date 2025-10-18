# This one brings our custom packages from the 'pkgs' directory
{...}: final: _prev:
import ../pkgs {pkgs = final;}
