import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

extension BuildContextX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  bool get hasVirtualHome => mediaQuery.padding.bottom > 0;
  S get s => S.of(this);
}
