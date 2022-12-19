import 'package:flutter/material.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T data);


// The script renders multiple view types in a list view.
// Refer docs: https://gist.github.com/cogivn/5489743cc6129df09c3511429beb9e17
class ItemViewTypeRegistry {
  final Map<Type, ItemWidgetBuilder> _builders;

  ItemViewTypeRegistry._(this._builders);

  factory ItemViewTypeRegistry.create({
    required final Map<Type, ItemWidgetBuilder> viewTypes,
  }) => ItemViewTypeRegistry._(viewTypes);


  Widget build<T>(BuildContext context, T item) {
    final builder = _builders[T];
    if (builder == null) {
      throw BinderNotFoundException(T.toString());
    }
    return builder(context, item);
  }
}

class BinderNotFoundException implements Exception {
  const BinderNotFoundException(this.clazz);

  final dynamic clazz;

  @override
  String toString() {
    return 'Have you registered the `$clazz` view type in the delegates field? '
        '\n\nPlease double-check that the `$clazz` has been '
        'added to the delegates field when creating the ItemViewTypeAdapter.\n';
  }
}