#!/bin/sh

# this is a little helper
# it creates new wheel: a gearwheel.d subdirectory with simlinks to the Default profile.
# You can run this script, rename target directory and delete-unneeded rename-needed symlinks.

DEF_PROFILE="$PWD/DEFAULT"
NEW_PROFILE="wheel-$(date +%s)"

(
 mkdir -v "$NEW_PROFILE"\
 && pushd "$DEF_PROFILE"\
 && for claw in *
 do
  ln -vs "../DEFAULT/$claw" "../$NEW_PROFILE/$claw"
 done

 popd #"$DEF_PROFILE"
)
