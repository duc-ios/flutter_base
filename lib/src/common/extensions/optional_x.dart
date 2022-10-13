extension AsExtension on Object? {
  X as<X>() => this as X;
  X? asOrNull<X>() {
    var self = this;
    return self is X ? self : null;
  }

  bool get isNullOrEmpty {
    final object = this;
    if (object is String) {
      return object.trim().isEmpty;
    } else if (object is List) {
      return object.isEmpty;
    }
    return object == null;
  }
}

extension AsSubtypeExtension<X> on X {
  Y asSubtype<Y extends X>() => this as Y;
}

extension AsNotNullExtension<X> on X? {
  X asNotNull() => this as X;
}
