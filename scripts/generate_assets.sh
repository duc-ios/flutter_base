sh scripts/webp.sh
if which fluttergen >/dev/null; then
  fluttergen
else
  echo "warning: fluttergen (https://pub.dev/packages/flutter_gen) is not installed"
fi
dart run intl_utils:generate