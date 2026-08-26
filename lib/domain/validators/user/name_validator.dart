import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/Extensions/string_validate.dart';

/// Validates person names according to the Domain rules.
///
/// [NameValidator] is responsible for validating names before they are
/// allowed to enter the Domain through the [PersonName] Value Object.
///
/// The current Domain rules require a name to:
///
/// - Exist and not be null.
/// - Not be empty or contain only whitespace.
/// - Contain English letters only.
/// - Contain between 3 and 12 characters.
///
/// Examples of valid names:
///
/// ```text
/// Marco
/// Adam
/// Michael
/// ```
abstract final class NameValidator {
  /// Regular expression defining the allowed name format.
  ///
  /// The expression:
  ///
  /// ```text
  /// ^[A-Za-z]{3,12}$
  /// ```
  ///
  /// means:
  ///
  /// - `^` → Start of the string.
  /// - `[A-Za-z]` → Only English alphabetic characters.
  /// - `{3,12}` → The name must contain between 3 and 12 characters.
  /// - `$` → End of the string.
  ///
  /// Therefore, values such as:
  ///
  /// ```text
  /// Marco       ✓
  /// Michael     ✓
  /// ma          ✗ Too short
  /// Marco123    ✗ Contains numbers
  /// Marco_      ✗ Contains special characters
  /// ```
  ///
  /// are handled according to the Domain rules.
  static final RegExp _regExpName = RegExp(r'^[A-Za-z]{3,12}$');

  /// Validates a name and returns its cleaned value.
  ///
  /// [name] is nullable because the caller may not have provided
  /// a value.
  ///
  /// [nameType] describes what kind of name is being validated.
  /// This allows the thrown exception message to be more meaningful.
  ///
  /// Example:
  ///
  /// ```dart
  /// NameValidator.validateOrThrow(
  ///   name: firstName,
  ///   nameType: 'first name',
  /// );
  /// ```
  ///
  /// The validation process is:
  ///
  /// ```text
  /// Raw Name
  ///     ↓
  /// Null / Empty Check
  ///     ↓
  /// Trim Whitespace
  ///     ↓
  /// Format Validation
  ///     ↓
  /// Clean Name
  /// ```
  ///
  /// Throws:
  ///
  /// - [EmptyValueException] when the name is null or empty.
  /// - [InvalidFormatException] when the name does not follow
  ///   the required format.
  static String validateOrThrow({
    required String? name,
    String nameType = "name",
  }) {
    // Check whether the provided name is null, empty, or contains
    // only whitespace.
    //
    // The extension keeps this check readable and reusable.
    if (name.isNullOrEmpty) {
      throw EmptyValueException("The $nameType must not be empty.");
    }

    // Remove unnecessary whitespace surrounding the name.
    //
    // Example:
    //
    // "  Marco  " → "Marco"
    final trimmedName = name!.trim();

    // Validate the cleaned name against the Domain's name format.
    //
    // The name must contain only English letters and must be
    // between 3 and 12 characters long.
    if (!trimmedName.isValid(_regExpName)) {
      throw InvalidFormatException(
        "The $nameType must contain only letters (3-12 characters).",
      );
    }

    // Return the validated and cleaned name.
    //
    // At this point, the value has successfully passed all
    // Domain validation rules.
    return trimmedName;
  }
}
