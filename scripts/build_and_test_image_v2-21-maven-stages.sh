#!/bin/bash

REVISION="v2-21-maven-stages"

echo "🏷️ REVISION: $REVISION"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/build_and_test_image_include.sh"