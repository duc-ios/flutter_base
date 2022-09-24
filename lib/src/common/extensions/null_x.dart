T? cast<T>(x) => x is T ? x : null;

extension OptionalObject on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
  T? asOrNull<T>() => cast(this);
}

extension OptionalString on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
  String valueOrEmpty() => this ?? '';
}

extension OptionalList on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}

extension ListX on List {
  T? firstOrNull<T>() => isEmpty ? null : first;
}
