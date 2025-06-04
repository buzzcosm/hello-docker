#!/bin/bash

REVISION="v1-21-maven-simple"

echo "🏷️ REVISION: $REVISION"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/build_and_test_image_include.sh"