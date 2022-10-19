#!/bin/bash

echo "Preparing the Drogon JWT plugin for the installation" && \
  git submodule init && git submodule update && \
  echo "The Drogon JWT plugin is prepared for the installation"