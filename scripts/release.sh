#!/usr/bin/env bash

bump_version=false
bump_build=true
generate=true
build_ios=true
build_android=true

while getopts v:b:g:a:i: flag; do
  case "${flag}" in
  v) bump_version=${OPTARG} ;;
  b) bump_build=${OPTARG} ;;
  g) generate=${OPTARG} ;;
  i) build_ios=${OPTARG} ;;
  a) build_android=${OPTARG} ;;
  esac
done

echo "bump_version: $bump_version"
echo "bump_build: $bump_build"
echo "generate: $generate"

# echo "Select flavor to build"
select flavor in "alpha" "dev" "prg" "uat" "prd"; do
  echo "Selected flavor: #$flavor"

  export_method=enterprise
  case $flavor in
  "prd") export_method=app-store ;;
  esac
  echo "export_method: $export_method"

  if [ $bump_version == true ]; then
    # Bump version number (dart pub global activate magical_version_bump)
    mag modify bump --targets 'patch'
  fi

  if [ $bump_build == true ]; then
    # Bump build number (dart pub global activate magical_version_bump)
    mag modify bump --targets 'build-number'
  fi

  app_name=$(grep -m 1 'name: ' pubspec.yaml | head -1 | sed 's/name: //')
  version=$(grep 'version: ' pubspec.yaml | sed 's/version: //' | sed 's/+/_/')
  file_name="${app_name}_${flavor}_${version}"
  echo "Preparing build: $file_name"

  if [ $generate == true ]; then
    # Generate assets
    echo "Generating..."
    flutter pub get
    dart run build_runner build --delete-conflicting-outputs
    sh scripts/generate_assets.sh
  else
    echo "Building without generating..."
  fi

  if [ $build_android == true ]; then
    # Build and open apk
    apk_path="build/app/outputs/flutter-apk/${file_name}.apk"
    flutter build apk --flavor $flavor &&
      mv "build/app/outputs/flutter-apk/app-${flavor}-release.apk" $apk_path &&
      open build/app/outputs/flutter-apk
  fi

  if [ $build_ios == true ]; then
    # Build and open ipa
    ipa_path="build/ios/ipa/${file_name}.ipa"
    if [ $flavor == "prd" ]; then
      flutter build ipa --release --export-options-plist scripts/export.plist --flavor $flavor
    else
      flutter build ipa --release --export-method $export_method --flavor $flavor
    fi
  fi

  mv build/ios/ipa/$app_name.ipa $ipa_path

  if [ $export_method == "app-store" ]; then
    sh scripts/tf.sh $flavor
  else
    open build/ios/ipa
  fi

  # Commit and tag this change.
  git add .
  git commit -m "$flavor/$version"
  git tag "$flavor/$version" -f

  exit 0
done
