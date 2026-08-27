import 'package:finora/domain/exception/user/empty_value_exception.dart';
import 'package:finora/domain/exception/user/invalid_format_exception.dart';
import 'package:finora/domain/Extensions/string_validate.dart';

/// Validates transaction titles according to the domain rules.
///
/// [TitleValidator] is responsible for validating raw transaction title
/// values before they are wrapped inside the [TransactionTitle] value object.
///
/// A valid transaction title must:
/// - Not be null or empty.
/// - Contain between 3 and 25 characters.
/// - Allow English letters.
/// - Allow Arabic letters.
/// - Allow numeric digits.
/// - Allow spaces.
/// - Allow the `.` character.
///
/// Examples of valid titles:
/// - `Grocery`
/// - `Monthly Rent`
/// - `شراء ملابس`
/// - `Food 2026`
/// - `Invoice.01`
///
/// This class contains only static validation logic and therefore does not
/// need to be instantiated.
abstract final class TitleValidator {
  /// Regular expression defining the allowed transaction title format.
  ///
  /// The expression allows:
  ///
  /// - `a-zA-Z` → English letters.
  /// - `0-9` → Numeric digits.
  /// - `.` → Period character.
  /// - `\s` → Whitespace characters.
  /// - `\u0600-\u06FF` → Arabic Unicode character range.
  ///
  /// The `{3,25}` constraint requires the complete title to contain between
  /// 3 and 25 allowed characters.
  static final RegExp _regExpTitle = RegExp(
    r'^[a-zA-Z0-9.\s\u0600-\u06FF]{3,25}$',
  );

  /// Validates a transaction title and returns its cleaned value.
  ///
  /// The validation process follows these steps:
  ///
  /// 1. Check whether the title is null or empty.
  /// 2. Remove leading and trailing whitespace.
  /// 3. Validate the cleaned title against [_regExpTitle].
  /// 4. Return the trimmed and validated title.
  ///
  /// Throws:
  /// - [EmptyValueException] when the title is null or empty.
  /// - [InvalidFormatException] when the title does not follow the required
  ///   format or length restrictions.
  static String validateOrThrow({required String? title}) {
    // Reject null or empty titles before attempting any further processing.
    if (title.isNullOrEmpty) {
      throw const EmptyValueException("The title must not be empty.");
    }

    // Remove accidental whitespace from the beginning and end of the title.
    final trimmedTitle = title!.trim();

    // Ensure that the title follows the allowed characters and length rules.
    if (!trimmedTitle.isValid(_regExpTitle)) {
      throw InvalidFormatException(
        "The title must contain 3-25 characters and may include "
        "letters, numbers, spaces, or '.'.",
      );
    }

    // Return the cleaned value so the Value Object receives only valid data.
    return trimmedTitle;
  }
}
