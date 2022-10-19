#!/bin/bash

HERE="$(pwd)"
CURRENT_SCRIPT="$HERE/Versionable/current.sh"

if ! test -e "$CURRENT_SCRIPT"; then

  echo "ERROR: The current script was not found at path: '$CURRENT_SCRIPT'"
  exit 1
fi

sh "$CURRENT_SCRIPT"
