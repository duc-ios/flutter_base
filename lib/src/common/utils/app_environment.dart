import 'package:flutter_config/flutter_config.dart';

class AppEnvironment {
  static setup() async {
    await FlutterConfig.loadEnvVariables();
  }

  static final flavor = FlutterConfig.get('FLAVOR');
  static final appID = FlutterConfig.get('APP_ID');
  static final apiUrl = FlutterConfig.get('API_URL');
  static final appName = FlutterConfig.get('APP_NAME');
}
