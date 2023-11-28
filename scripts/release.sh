#!/usr/bin/env bash

printf "Select flavor to build\n"
select flavor in "dev" "prg" "uat" "prd"; do
  echo "Selected flavor: #$flavor"

  export_method=enterprise
  case $flavor in
  "prd") export_method=app-store ;;
  esac
  echo "export_method: $export_method"

  # Bump build number
  perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml
  app_name=$(grep -m 1 'name: ' pubspec.yaml | head -1 | sed 's/name: //')
  version=$(grep 'version: ' pubspec.yaml | sed 's/version: //' | sed 's/+/_/')
  file_name="${app_name}_${flavor}_${version}"
  echo "Preparing build: $file_name"

  # Generate assets
  flutter pub get
  dart run build_runner build --delete-conflicting-outputs
  sh scripts/generate_assets.sh

  # Build and open apk
  apk_path="build/app/outputs/flutter-apk/${file_name}.apk"
  flutter build apk --flavor $flavor &&
    mv "build/app/outputs/flutter-apk/app-${flavor}-release.apk" $apk_path &&
    open build/app/outputs/flutter-apk

  # Build and open ipa
  ipa_path="build/ios/ipa/${file_name}.ipa"
  if [ $flavor == "prd" ]
  then
    flutter build ipa --release --export-options-plist scripts/export.plist --flavor $flavor
  else
    flutter build ipa --release --export-method $export_method --flavor $flavor
  fi

  mv build/ios/ipa/$app_name.ipa $ipa_path
    
  if [ $export_method == "app-store" ]
  then
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