import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:talker_flutter/talker_flutter.dart';

import 'getit_utils.dart';

@module
abstract class LoggerModule {
  @singleton
  Talker talker() => TalkerFlutter.init(
    settings: TalkerSettings(
      useConsoleLogs: kDebugMode,
      colors: {
        TalkerLogType.debug: AnsiPen()..green(),
        TalkerLogType.warning: AnsiPen()..yellow(bold: true),
        TalkerLogType.error: AnsiPen()..red(bold: true)
      },
    ),
  );
}

final logger = _Logger(getIt<Talker>());

class _Logger {
  final Talker talker;
  _Logger(this.talker);

  // White text
  d(dynamic msg, {
    Object? exception,
    StackTrace? stackTrace,
  }) => talker.debug(msg, exception, stackTrace);


  // Blue text
  i(dynamic msg, {
    Object? exception,
    StackTrace? stackTrace,
  }) => talker.info(msg, exception, stackTrace);

  // Yellow text
  w(dynamic msg, {
    Object? exception,
    StackTrace? stackTrace,
  }) => talker.warning(msg, exception, stackTrace);

  // Red text
  e(dynamic msg, {
    Object? exception,
    StackTrace? stackTrace,
  }) => talker.error(msg, exception, stackTrace);
}
