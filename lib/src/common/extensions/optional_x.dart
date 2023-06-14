import 'package:dartx/dartx.dart';

T? cast<T>(x) => x is T ? x : null;

extension OptionalObject on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}

extension OptionalString on String? {
  bool get isNullOrBlank => this == null || this!.isBlank;

  bool get isNotNullOrBlank => !isNullOrBlank;
}

extension OptionalList on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension ListX on List {
  T? firstOrNull<T>() => isEmpty ? null : first;
}

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

  bool get isNotNullOrEmpty => !isNullOrEmpty;
}

extension AsSubtypeExtension<X> on X {
  Y asSubtype<Y extends X>() => this as Y;
}

extension AsNotNullExtension<X> on X? {
  X asNotNull() => this as X;
}
