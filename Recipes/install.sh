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

LINK_LIB_JSON="$HERE/Library/json"
LINK_LIB_CPP_JWT="$HERE/Library/cpp-jwt"

function DO_LINK {

  LINK="$1"
  DIR_IN="$2"
  DIR_OUT="$3"

  if test -e "$LINK"; then

    if [ -L "$LINK" ] && [ -e "$LINK" ]; then

      echo "Link is ok (1): $LINK"

    else

      echo "ERROR: Link is broken (1): $LINK"
      exit 1
    fi

  else

    if ! ln -s "$DEPENDENCIES_WORKING_DIRECTORY/Cache/$DIR_IN/Library" "$HERE/Library/$DIR_OUT"; then

      echo "ERROR: Could not link the 'json' dependency"
      exit 1
    fi

    if [ -L "$LINK" ] && [ -e "$LINK" ]; then

      echo "Link is ok (2): $LINK"

    else

      echo "ERROR: Link is broken (2): $LINK"
      exit 1
    fi
  fi
}

DO_LINK "$LINK_LIB_JSON" "JSON" "json"
DO_LINK "$LINK_LIB_CPP_JWT" "CPP-JWT" "cpp-jwt"

cd "$HERE" && cd "Library" && \
  rm -rf ./Build && \
  mkdir Build && \
  cd Build && \
  cmake -GNinja ..