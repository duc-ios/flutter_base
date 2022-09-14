#!/usr/bin/env bash

printf "Select flavor to build\n"
select flavor in "DEV" "PRG" "UAT" "PRD"; do
    echo "Selected flavor: #$flavor"

    export_method=enterprise
    case $flavor in
      "PRD" ) export_method=app-store ;;
    esac
    echo "export_method: $export_method"
    
    # Bump build number
    perl -i -pe 's/^(version:\s+\d+\.\d+\.\d+\+)(\d+)$/$1.($2+1)/e' pubspec.yaml
    app_name=`grep -m 1 'name: ' pubspec.yaml | head -1 | sed 's/name: //'`
    version=`grep 'version: ' pubspec.yaml | sed 's/version: //'`
    echo "Peparing build: ${app_name}_$version"

    # Generate assets
    flutter pub get
    flutter pub run build_runner build --delete-conflicting-outputs
    sh generate_assets.sh

    # Build and open apk
    flutter build apk --flavor $flavor &&
    mv build/app/outputs/flutter-apk/app.apk build/app/outputs/flutter-apk/${app_name}_$version.apk &&
    open build/app/outputs/flutter-apk

    # Build and open ipa
    flutter build ipa --export-method $export_method --flavor $flavor &&
    mv build/ios/ipa/$app_name.ipa build/ios/ipa/${app_name}_$version.ipa &&
    open build/ios/ipa

    # Commit and tag this change.
    git add .
    git commit -m "$flavor/$version"
    git tag "$flavor/$version" -f

    exit 0
done
