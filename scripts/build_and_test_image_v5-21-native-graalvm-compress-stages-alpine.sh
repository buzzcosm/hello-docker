#!/bin/bash

REVISION="v5-21-native-graalvm-compress-stages-alpine"

echo "🏷️ REVISION: $REVISION"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/build_and_test_image_include.sh"