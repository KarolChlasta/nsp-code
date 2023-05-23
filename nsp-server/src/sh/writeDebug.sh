#!/bin/bash
# write NSP echo with prompt
if [ -n $nsp_debug ]; then
  # Check if the VARNAME variable is greater than zero
  if [[ "$nsp_debug" -gt 0 ]]; then
    echo "NSP DEBUG> $@"
  fi
fi
