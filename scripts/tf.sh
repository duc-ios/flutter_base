#!/usr/bin/env bash

app_name=$(grep -m 1 'name: ' pubspec.yaml | head -1 | sed 's/name: //')
version=$(grep 'version: ' pubspec.yaml | sed 's/version: //' | sed 's/+/_/')
file_name="${app_name}_$1_${version}.ipa"
fastlane pilot upload --ipa "build/ios/ipa/$file_name" --distribute_external true -g $1 -w "bug fixes"
