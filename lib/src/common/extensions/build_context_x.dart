import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';
import '../theme/app_theme_wrapper.dart';
import '../theme/text_theme_interfaces.dart';

extension BuildContextX on BuildContext {
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  TextThemeFactory get textTheme {
    return AppThemeInheritWidget.of(this).factory;
  }
  bool get hasVirtualHome => mediaQuery.padding.bottom > 0;
  S get s => S.of(this);
}
