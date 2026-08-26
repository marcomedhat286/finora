/// Thrown when a username has already been registered by another user.
///
/// Unlike [EmptyValueException] and [InvalidFormatException], this
/// exception does not indicate that the username itself is malformed.
///
/// Instead, the username is structurally valid but cannot be used
/// because it is already owned by another user.
///
/// Example:
///
/// ```text
/// User enters: marco@123
///       ↓
/// Username format is valid
///       ↓
/// Repository checks availability
///       ↓
/// Username already exists
///       ↓
/// TakenUserNameException
/// ```
///
/// This exception is typically raised by the registration flow after
/// checking username availability through the [UserRepository].
class TakenUserNameException implements Exception {
  /// A human-readable description of why the username cannot be used.
  final String message;

  /// Creates a [TakenUserNameException] with the specified [message].
  const TakenUserNameException({required this.message});

  /// Returns the exception message when the exception is converted
  /// to a String.
  @override
  String toString() => message;
}
