#!/bin/bash

_user="$(id -u -n)"

if [ "$_user" == "researcher" ]; then
  export JULIA_PKGDIR=/opt/julia
fi
