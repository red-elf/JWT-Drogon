#!/bin/bash

HERE="$(pwd)"
VERSIONABLE_BUILD_SCRIPT="$HERE/Versionable/versionable_build.sh"
VERSIONABLE_INSTALL_SCRIPT="$HERE/Versionable/versionable_install.sh"

if ! test -e "$VERSIONABLE_BUILD_SCRIPT"; then

  echo "ERROR: The versionable build script not found at expected location: '$VERSIONABLE_BUILD_SCRIPT'"
  exit 1
fi

if ! test -e "$VERSIONABLE_INSTALL_SCRIPT"; then

  echo "ERROR: The versionable install script not found at expected location: '$VERSIONABLE_INSTALL_SCRIPT'"
  exit 1
fi

cd "$HERE" && echo "Preparing the dependency linking"

if ! test -e "$HERE/Library/json";

  if ! ln -s "$HERE/_Dependencies/Cache/JSON/Library" "$HERE/Library/json"; then

    echo "ERROR: Could not link the 'json' dependency"
    exit 1
  fi
then

if ! test -e "$HERE/Library/cpp-jwt";

  if ! ln -s "$HERE/_Dependencies/Cache/CPP-JWT/Library" "$HERE/Library/cpp-jwt"; then

    echo "ERROR: Could not link the 'cpp-jwt' dependency"
    exit 1
  fi
then

sh "$VERSIONABLE_BUILD_SCRIPT" Library ..

# TODO:
# &&  sh "$VERSIONABLE_INSTALL_SCRIPT" Library
