import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/utils/logger.dart';
import '../../../../modules/auth/infrastructure/models/user_model.dart';

class _Keys {
  static const box = 'box';
  static const lang = 'lang';
  static const user = 'user';
  static const accessToken = 'access_token';
  static const deviceId = 'device_id';
  static const pushToken = 'push_token';
}

class Storage {
  static final _box = Hive.box(_Keys.box);
  static const _storage = FlutterSecureStorage();

  static setup() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    try {
      await Hive.openBox(_Keys.box);
    } catch (error) {
      logger.e(error);
      try {
        await Hive.deleteBoxFromDisk(_Keys.box);
      } catch (error) {
        logger.e(error);
      }
      await Hive.openBox(_Keys.box);
    }
  }

  static T? _get<T>(String key) => _box.get(key);
  static Future _set<T>(String key, T? val) => _box.put(key, val);
  static Future<String?> _getSecure(String key) => _storage.read(key: key);
  static Future<void> _setSecure(String key, String? val) =>
      _storage.write(key: key, value: val);

  static String? get lang => _get(_Keys.lang);
  static Future setLang(String? val) => _set(_Keys.lang, val);
  static UserModel? get user => _get(_Keys.user);
  static Future setUser(UserModel? val) => _set(_Keys.user, val);
  static Future<String?> get accessToken => _getSecure(_Keys.accessToken);
  static Future setAccessToken(String? val) =>
      _setSecure(_Keys.accessToken, val);
  static String get deviceId {
    String? deviceId = _get(_Keys.deviceId);
    if (deviceId == null) {
      deviceId = const Uuid().v4();
      setDeviceId(deviceId);
    }
    return deviceId;
  }

  static Future setDeviceId(String? val) => _set(_Keys.deviceId, val);
  static String? get pushToken => _get(_Keys.pushToken);
  static Future setPushToken(String? val) => _set(_Keys.pushToken, val);
}
