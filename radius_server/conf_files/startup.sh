#!/bin/bash

service freeradius start && /bin/echo "RADIUS CORRIENDO" && \
/bin/echo "Nivel de shell:$(/bin/echo "$SHLVL")" && \
/bin/bash ;exit 0
