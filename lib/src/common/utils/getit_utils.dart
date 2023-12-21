import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'app_environment.dart';
import 'getit_utils.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() => getIt.init(environment: AppEnvironment.flavor);

class GetItUtils {
  static setup() async => configureDependencies();
}
