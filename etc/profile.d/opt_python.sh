#!/bin/bash

_user="$(id -u -n)"

if [ "$_user" == "researcher" ]; then
  export PATH=/opt/python/bin:$PATH
  export IPYTHONDIR=/opt/ipython
fi
