#!/bin/bash

REVISION="v3-21-native-graalvm-stages"

echo "🏷️ REVISION: $REVISION"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/build_and_test_image_include.sh"