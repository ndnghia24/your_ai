#!/bin/bash

# Install Flutter
FLUTTER_DIR="/opt/flutter"
if [ ! -d "$FLUTTER_DIR" ]; then
  git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_DIR
fi

export PATH="$FLUTTER_DIR/bin:$PATH"

# Run flutter doctor to ensure Flutter is ready
flutter doctor
