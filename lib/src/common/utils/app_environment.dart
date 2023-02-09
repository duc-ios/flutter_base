import 'package:flutter_config/flutter_config.dart';

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
