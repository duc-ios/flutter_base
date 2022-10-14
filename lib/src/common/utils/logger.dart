import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:loggy/loggy.dart';
import 'package:stack_trace/stack_trace.dart';

final logger = _Logger();

class _Logger {
  _Logger() {
    Loggy.initLoggy(
      logPrinter: StreamPrinter(const PrettyDeveloperPrinter()),
    );
  }

  final _colors = {
    'v': '30',
    'd': '37',
    'i': '34',
    's': '32',
    'w': '33',
    'e': '31',
  };
  String _colorFor(String level) => '\x1B[${_colors[level]}m';

  // White text
  d(dynamic msg) =>
      logDebug('${_traceInfo()}\n${_colorFor('d')}${msg.toString()}\x1B[0m');

  // Blue text
  i(dynamic msg) =>
      logInfo('${_traceInfo()}\n${_colorFor('i')}${msg.toString()}\x1B[0m');

  // Yellow text
  w(dynamic msg) =>
      logWarning('${_traceInfo()}\n${_colorFor('w')}${msg.toString()}\x1B[0m');

  // Red text
  e(dynamic msg) =>
      logError('${_traceInfo()}\n${_colorFor('e')}${msg.toString()}\x1B[0m');

  String _traceInfo() =>
      Trace.from(StackTrace.current).terse.frames[2].toString();
}
