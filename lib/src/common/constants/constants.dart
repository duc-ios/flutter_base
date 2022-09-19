class Constants {
  static const elevation = 0.0;
  static const buttonHeight = 50.0;
  static const nearSpacing = 4.0;
  static const spacing = 8.0;
  static const nearPadding = 12.0;
  static const padding = 16.0;
  static const farPadding = 24.0;
  static const superFarPadding = 32.0;
  static const borderRadius = 3.0;
  static const cardRadius = 10.0;
  static const toastDuration = 3;
}

bool isNullOrEmpty(dynamic object) {
  if (object is String) {
    return object.isEmpty;
  } else if (object is List) {
    return object.isEmpty;
  }
  return true;
}
