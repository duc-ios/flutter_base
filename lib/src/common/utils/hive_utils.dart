import 'package:hive_flutter/hive_flutter.dart';

import '../../modules/auth/infrastructure/models/user_model.dart';

final box = Hive.box('box');

class HiveUtils {
  static setup() async {
    await Hive.initFlutter();
    Hive.registerAdapter(UserModelAdapter());
    try {
      await Hive.openBox('box');
    } catch (error) {
      await Hive.deleteBoxFromDisk('box');
      await Hive.openBox('box');
    }
  }
}

class BoxKeys {
  static const lang = 'lang';
  static const user = 'user';
}
