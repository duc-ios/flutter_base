#!/usr/bin/env bash

flavor="_"
bump_version=n
bump_build="y"
generate="y"
build_ios="y"
build_android="y"
export_method=enterprise

while getopts f:v:b:g:a:i: flag; do
  case "${flag}" in
  f) flavor=${OPTARG} ;;
  v) bump_version=${OPTARG} ;;
  b) bump_build=${OPTARG} ;;
  g) generate=${OPTARG} ;;
  i) build_ios=${OPTARG} ;;
  a) build_android=${OPTARG} ;;
  esac
done

function start() {
  echo "flavor: $flavor"
  echo "bump_version: $bump_version"
  echo "bump_build: $bump_build"
  echo "generate: $generate"
  echo "build_ios: $build_ios"
  echo "build_android: $build_android"
  echo "export_method: $export_method"

  # Bump version number (dart pub global activate magical_version_bump)
  if [ $bump_version == "y" ]; then
    mag modify bump --targets 'patch'
  else
    if [ $bump_version != "n" ]; then
      mag modify set --ver $bump_version
    fi
  fi

  # Bump build number (dart pub global activate magical_version_bump)
  if [ $bump_build == "y" ]; then
    mag modify bump --targets 'build-number'
  else
    if [ $bump_build != "n" ]; then
      mag modify set --build $bump_build
    fi
  fi

  app_name=$(grep -m 1 'name: ' pubspec.yaml | head -1 | sed 's/name: //')
  version=$(grep 'version: ' pubspec.yaml | sed 's/version: //' | sed 's/+/_/')
  file_name="${app_name}_${flavor}_${version}"
  echo "Preparing build: $file_name"

  if [ $generate == "y" ]; then
    # Generate assets
    echo "Generating..."
    flutter pub get
    dart run build_runner build --delete-conflicting-outputs
    sh scripts/generate_assets.sh
  else
    echo "Building without generating..."
  fi

  if [ $build_android == "y" ]; then
    # Build and open apk
    apk_path="build/app/outputs/flutter-apk/${file_name}.apk"
    flutter build apk --flavor $flavor &&
      mv "build/app/outputs/flutter-apk/app-${flavor}-release.apk" $apk_path &&
      open build/app/outputs/flutter-apk
  fi

  if [ $build_ios == "y" ]; then
    # Build and open ipa
    ipa_path="build/ios/ipa/${file_name}.ipa"
    if [ $flavor == "prd" ]; then
      flutter build ipa --release --export-options-plist scripts/export.plist --flavor $flavor
    else
      flutter build ipa --release --export-method $export_method --flavor $flavor
    fi
    mv build/ios/ipa/$app_name.ipa $ipa_path

    if [ $export_method == "app-store" ]; then
      sh scripts/tf.sh $flavor
    else
      open build/ios/ipa
    fi
  fi

  # Commit and tag this change.
  git add .
  git commit -m "build(release): bump version to $flavor/$version"
  git tag "release/$flavor/$version" -f

  exit 0
}

if [ $flavor == "_" ]; then
  select selected_flavor in "alpha" "dev" "prg" "uat" "prd"; do
    flavor=$selected_flavor
    case $flavor in
    "prd") export_method=app-store ;;
    esac
    start
  done
else
  start
fi
