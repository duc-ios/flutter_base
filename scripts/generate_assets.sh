if which fluttergen >/dev/null; then
  fluttergen
else
  echo "warning: fluttergen (https://pub.dev/packages/flutter_gen) is not installed"
fi

flutter pub run easy_localization:generate -S "assets/i18n" -f keys -o locale_keys.g.dart