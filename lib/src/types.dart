part of 'multi_value_listenable.dart';

/// A list of [ValueNotifier]s.
/// This is a convenience type for working with multiple [ValueNotifier]s.
typedef ListValueNotifier = List<ValueNotifier>;

/// A function that builds a widget depending on the values of a list of [ValueNotifier]s.
extension ListValueNotifierExtension on ListValueNotifier {
  void addListenerToAll(VoidCallback listener) {
    for (var listenable in this) {
      listenable.addListener(listener);
    }
  }

  void removeListenerFromAll(VoidCallback listener) {
    for (var listenable in this) {
      listenable.removeListener(listener);
    }
  }

  T get<T>() => whereType<T>().first;
}
