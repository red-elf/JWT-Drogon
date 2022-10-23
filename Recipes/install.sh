#!/bin/bash

HERE="$(pwd)"
VERSIONABLE_BUILD_SCRIPT="$HERE/Versionable/versionable_build.sh"
VERSIONABLE_INSTALL_SCRIPT="$HERE/Versionable/versionable_install.sh"

if [ -z "$DEPENDABLE_DEPENDENCIES_HOME" ]; then

  DEPENDABLE_DEPENDENCIES_HOME="$HERE"
fi

echo "The dependencies home directory: '$DEPENDABLE_DEPENDENCIES_HOME'"

DEPENDENCIES_WORKING_DIRECTORY="$DEPENDABLE_DEPENDENCIES_HOME/_Dependencies"

echo "The dependencies working directory: '$DEPENDENCIES_WORKING_DIRECTORY'"

if ! test -e "$VERSIONABLE_BUILD_SCRIPT"; then

  echo "ERROR: The versionable build script not found at expected location: '$VERSIONABLE_BUILD_SCRIPT'"
  exit 1
fi

if ! test -e "$VERSIONABLE_INSTALL_SCRIPT"; then

  echo "ERROR: The versionable install script not found at expected location: '$VERSIONABLE_INSTALL_SCRIPT'"
  exit 1
fi

cd "$HERE" && echo "Preparing the dependency linking"

LINK="$HERE/Library/json"

if test -e "$LINK"; then

  if [ -L "$LINK" ] && [ -e "$LINK" ]; then

    echo "Link is ok: $LINK"

  else

    echo "ERROR: Link is broken: $LINK"
    exit 1
  fi

else

  if ! ln -s "$DEPENDENCIES_WORKING_DIRECTORY/Cache/JSON/Library" "$HERE/Library/json"; then

    echo "ERROR: Could not link the 'json' dependency"
    exit 1
  fi
fi

LINK="$HERE/Library/cpp-jwt"

if test -e "$LINK"; then

  if [ -L "$LINK" ] && [ -e "$LINK" ]; then

    echo "Link is ok: $LINK"

  else

    echo "ERROR: Link is broken: $LINK"
    exit 1
  fi

else

  if ! ln -s "$DEPENDENCIES_WORKING_DIRECTORY/Cache/CPP-JWT/Library" "$HERE/Library/cpp-jwt"; then

    echo "ERROR: Could not link the 'cpp-jwt' dependency"
    exit 1
  fi
fi

LINK="$HERE/Library/json"

if [ -L "$LINK" ] && [ -e "$LINK" ]; then

  echo "Link is ok: $LINK"

else

  echo "ERROR: Link is broken: $LINK"
  exit 1
fi

LINK="$HERE/Library/cpp-jwt"

if [ -L "$LINK" ] && [ -e "$LINK" ]; then

  echo "Link is ok: $LINK"

else

  echo "ERROR: Link is broken: $LINK"
  exit 1
fi

# TODO: Move the redundant code into the functions

cd "$HERE" && cd "Library" && \
  rm -rf ./Build && \
  mkdir Build && \
  cd Build && \
  cmake -GNinja ..