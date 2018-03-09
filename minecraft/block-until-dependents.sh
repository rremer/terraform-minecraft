#!/bin/bash
#
# block until some dependencies are met by other modules
#

set -u

while true; do
 which aptdcon && break
done
