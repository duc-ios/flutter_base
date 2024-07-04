import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app_environment.dart';
import 'getit_utils.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies({required String flavor}) =>
    getIt.init(environment: flavor);

class GetItUtils {
  static setup({String? flavor}) async => configureDependencies(
        flavor: flavor ?? AppEnvironment.flavor,
      );
}
