import 'dart:math';

///               14/7
/// Adds utility methods for retrieving random elements from a list.
///
/// This extension provides a convenient way to select a random item
/// without requiring callers to manually generate random indices.
///
/// Example:
///
/// ```dart
/// final colors = ['Red', 'Green', 'Blue'];
///
/// final color = colors.randomItem();
/// ```
///
/// Throws a [StateError] when attempting to retrieve an item
/// from an empty list.
extension RandomItem<T> on List<T> {
  /// Shared pseudo-random number generator.
  ///
  /// Reusing a single instance avoids creating unnecessary [Random]
  /// objects every time a random element is requested and improves
  /// performance for repeated calls.
  static final Random _random = Random();

  /// Returns a randomly selected element from this list.
  ///
  /// Every element has an equal probability of being selected.
  ///
  /// Throws:
  ///
  /// - [StateError] if the list is empty.
  T randomItem() {
    /// A random element cannot be selected from an empty collection.
    if (isEmpty) {
      throw StateError("Cannot retrieve a random item from an empty list.");
    }

    /// Generate a random valid index and return the corresponding element.
    return this[_random.nextInt(length)];
  }
}
