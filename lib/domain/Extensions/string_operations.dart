/// Provides reusable string manipulation operations used throughout
/// the application.
///
/// This extension keeps common string-related transformations in one place,
/// allowing the Domain layer and other parts of the application to reuse
/// consistent string-processing behavior without duplicating logic.
extension StringOperations on String {
  /// Returns a new string with the first character converted to uppercase.
  ///
  /// If the string is empty, the original string is returned unchanged.
  ///
  /// Example:
  /// ```dart
  /// 'marco'.capitalizeFirst(); // 'Marco'
  /// 'hello'.capitalizeFirst(); // 'Hello'
  /// ''.capitalizeFirst();      // ''
  /// ```
  ///
  /// This operation affects only the first character and leaves the
  /// remaining characters unchanged.
  String capitalizeFirst() {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1);
  }

  /// Returns a short initials representation of the string.
  ///
  /// The method first removes leading and trailing whitespace and then
  /// separates the string into words.
  ///
  /// Behavior:
  /// - For an empty string, returns an empty string.
  /// - For a single word, returns the first two characters when available.
  /// - For multiple words, returns the first character of the first two words.
  /// - The resulting initials are always converted to uppercase.
  ///
  /// Examples:
  /// ```dart
  /// 'marco'.initials;          // 'MA'
  /// 'marco medhat'.initials;   // 'MM'
  /// 'marco medhat ali'.initials; // 'MM'
  /// '  marco  '.initials;      // 'MA'
  /// ''.initials;               // ''
  /// ```
  ///
  /// This is particularly useful for generating compact user representations,
  /// such as profile avatars, account placeholders, or list items.
  String get initials {
    final words = trim().split(RegExp(r'\s+'));

    if (words.isEmpty) return '';

    if (words.length == 1) {
      return words[0].length >= 2
          ? words[0].substring(0, 2).toUpperCase()
          : words[0].toUpperCase();
    }

    final firstLetter = words[0][0];
    final secondLetter = words[1][0];

    return '$firstLetter$secondLetter'.toUpperCase();
  }
}
