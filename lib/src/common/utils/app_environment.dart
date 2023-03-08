import 'package:flutter_config_plus/flutter_config_plus.dart';

typedef FlutterConfig = FlutterConfigPlus;

class AppEnvironment {
  static setup() async {
    await FlutterConfig.loadEnvVariables();
  }

  static final flavor = FlutterConfig.get('FLAVOR');
  static final packageName = FlutterConfig.get('PACKAGE_NAME');
  static final bundleId = FlutterConfig.get('BUNDLE_ID');
  static final apiUrl = FlutterConfig.get('API_URL');
  static final appName = FlutterConfig.get('APP_NAME');
}
