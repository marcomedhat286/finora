/// Provides reusable validation helpers for nullable strings.
///
/// This extension centralizes common string validation logic so that
/// different parts of the application can perform consistent checks
/// without duplicating null and empty-value handling.
extension StringValidate on String? {
  /// Determines whether the string is either `null` or empty after trimming.
  ///
  /// Leading and trailing whitespace is ignored when checking whether
  /// the string contains a meaningful value.
  ///
  /// Returns `true` when:
  /// - The string is `null`.
  /// - The string is empty.
  /// - The string contains only whitespace.
  ///
  /// Returns `false` when the string contains at least one non-whitespace
  /// character.
  ///
  /// Examples:
  /// ```dart
  /// null.isNullOrEmpty;     // true
  /// ''.isNullOrEmpty;       // true
  /// '   '.isNullOrEmpty;    // true
  /// 'Marco'.isNullOrEmpty;  // false
  /// ```
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;

  /// Checks whether the current string matches the provided regular expression.
  ///
  /// The regular expression defines the format that the string is expected
  /// to follow.
  ///
  /// This method is intended to be used after confirming that the value
  /// is not null or empty.
  ///
  /// Example:
  /// ```dart
  /// final nameRegex = RegExp(r'^[A-Za-z]{3,12}$');
  ///
  /// 'Marco'.isValid(nameRegex); // true
  /// 'M1'.isValid(nameRegex);    // false
  /// ```
  ///
  /// **Important:** This method assumes that the string is not `null`.
  /// Calling it with a `null` value will cause a runtime exception because
  /// the nullable value is force-unwrapped internally.
  bool isValid(RegExp regex) => regex.hasMatch(this!);
}
