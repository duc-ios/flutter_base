import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:uuid/uuid.dart';

import '../../../../common/extensions/optional_x.dart';
import '../../../../common/utils/logger.dart';
import '../../../../modules/auth/infrastructure/models/user_model.dart';

class _Keys {
  static const lang = 'lang';
  static const user = 'user';
  static const accessToken = 'access_token';
  static const deviceId = 'device_id';
  static const pushToken = 'push_token';
}

class Storage {
  static late final SharedPreferences _prefs;
  static late final RxSharedPreferences _rxPrefs;

  static const _storage = FlutterSecureStorage();

  static setup() async {
    _prefs = await SharedPreferences.getInstance();

    /// A shared preference wrapper providing [Stream] for listening updates
    /// from shared preference by key
    _rxPrefs = RxSharedPreferences(
      _prefs,
      // disable logging when running in release mode.
      kReleaseMode ? null : const RxSharedPreferencesDefaultLogger(),
    );
  }

  static T? _get<T>(String key) => _prefs.get(key).asOrNull<T>();

  /// set value to shared preference by [key].
  /// If you want the updated value to be notified for stream subscriptions
  /// created by [RxSharedPreferences], please set [notify] as `true`
  static Future<void> _set<T>(String key, T? val, {bool notify = false}) {
    if (val is bool) {
      return notify ? _rxPrefs.setBool(key, val) : _prefs.setBool(key, val);
    }
    if (val is double) {
      return notify ? _rxPrefs.setDouble(key, val) : _prefs.setDouble(key, val);
    }
    if (val is int) {
      return notify ? _rxPrefs.setInt(key, val) : _prefs.setInt(key, val);
    }
    if (val is String) {
      return notify ? _rxPrefs.setString(key, val) : _prefs.setString(key, val);
    }
    if (val is List<String>) {
      return notify
          ? _rxPrefs.setStringList(key, val)
          : _prefs.setStringList(key, val);
    }
    throw Exception('Type not supported!');
  }

  static Future<String?> _getSecure(String key) => _storage.read(key: key);

  static Future<void> _setSecure(String key, String? val) =>
      _storage.write(key: key, value: val);

  static String? get lang => _get(_Keys.lang);

  static Future setLang(String? val) => _set(_Keys.lang, val);

  static UserModel? get user {
    final userString = _get<String>(_Keys.user);
    return _parseUser(userString);
  }

  static Stream<UserModel?> get userStream {
    return _rxPrefs
        .getStringStream(_Keys.user)
        .map((event) => _parseUser(event));
  }

  static UserModel? _parseUser(String? userString) {
    try {
      if (userString != null) {
        return UserModel.fromJson(json.decode(userString));
      }
    } catch (e) {
      logger.e(e);
    }
    return null;
  }

  static Future<void> setUser(UserModel? val) =>
      _set(_Keys.user, json.encode(val?.toJson()));

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
