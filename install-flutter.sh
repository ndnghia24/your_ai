#!/bin/bash

FLUTTER_DIR="/opt/flutter"
if [ ! -d "$FLUTTER_DIR" ]; then
  echo "Installing Flutter..."
  git clone https://github.com/flutter/flutter.git -b stable $FLUTTER_DIR
else
  echo "Flutter is already installed."
fi

export PATH="$FLUTTER_DIR/bin:$PATH"
flutter doctor
which flutter