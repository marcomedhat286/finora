/// Exception thrown when a user-provided String cannot be converted
/// into a valid [double] value.
///
/// [InvalidDoubleFormatException] represents an input-parsing failure
/// that occurs when textual input does not contain a valid numeric
/// representation.
///
/// This exception is intended for the Presentation Layer, where raw
/// user input is received and parsed before being passed to the
/// Domain Layer.
///
/// For example, the following inputs may cause this exception:
///
/// ```text
/// "abc"
/// "12abc"
/// "one thousand"
/// ```
///
/// The exception does not determine whether a numeric value is
/// financially valid. It only indicates that the provided text could
/// not be converted into a [double].
///
/// Financial business rules such as whether negative amounts or zero
/// are allowed should be handled separately by the Domain Layer,
/// for example through [MoneyValidator].
class InvalidDoubleFormatException implements Exception {
  /// A descriptive message explaining why the input could not
  /// be converted into a valid numeric value.
  ///
  /// The message should provide enough information for the
  /// Presentation Layer to display or handle the parsing error.
  final String message;

  /// Creates an [InvalidDoubleFormatException] with the specified
  /// [message].
  ///
  /// The constructor is constant because the exception contains
  /// immutable data and does not require runtime initialization.
  const InvalidDoubleFormatException(this.message);

  /// Returns the exception message as the String representation
  /// of this exception.
  ///
  /// This makes the exception convenient for logging, debugging,
  /// and presenting the parsing error to the user.
  @override
  String toString() => message;
}
