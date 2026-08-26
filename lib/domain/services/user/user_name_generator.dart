import 'package:finora/domain/Extensions/random_item.dart';
import 'package:finora/domain/services/user/random_digits_generator.dart';
import 'package:finora/domain/validators/user/name_validator.dart';
import 'package:finora/domain/value_object/user/user_name.dart';

/// Generates valid [UserName] Value Objects from a user's name.
///
/// [UserNameGenerator] is a Domain Service responsible for creating
/// usernames automatically when the user does not provide one manually.
///
/// The generated username follows the Domain format:
///
/// ```text
/// First Name + Random Symbol + Random Digits
/// ```
///
/// Example:
///
/// ```text
/// marco + @ + 472
///       ↓
/// marco@472
/// ```
///
/// The generation process is:
///
/// ```text
/// First Name
///     ↓
/// NameValidator
///     ↓
/// Validated Name
///     ↓
/// Random Symbol
///     ↓
/// Random Digits
///     ↓
/// Combine All Parts
///     ↓
/// UserName.create()
///     ↓
/// UserNameValidator
///     ↓
/// Valid UserName
/// ```
///
/// This service does not directly construct a username through
/// a public constructor. Instead, the final value is passed through
/// [UserName.create] so the complete username is validated before
/// entering the Domain.
///
/// This keeps username generation and username validation as two
/// separate responsibilities:
///
/// - [UserNameGenerator] → Generates a candidate username.
/// - [UserName] → Represents a valid username.
/// - [UserNameValidator] → Enforces the username format rules.
abstract final class UserNameGenerator {
  /// Symbols that can be placed between the user's name and
  /// the generated numeric suffix.
  ///
  /// A symbol is selected randomly during username generation.
  ///
  /// Supported separators:
  ///
  /// ```text
  /// @
  /// _
  /// -
  /// ```
  static const List<String> _symbols = ['@', '_', '-'];

  /// Generates a new [UserName] based on the provided [name].
  ///
  /// The provided name is first validated using [NameValidator].
  /// This ensures that the name used as the username prefix is valid
  /// according to the Domain name rules.
  ///
  /// A random separator is then selected from [_symbols], followed
  /// by a randomly generated sequence of digits.
  ///
  /// The three components are combined to produce the final username.
  ///
  /// Example:
  ///
  /// ```text
  /// name   = "marco"
  /// symbol = "@"
  /// number = "472"
  ///
  /// Result:
  /// "marco@472"
  /// ```
  ///
  /// The generated String is finally passed to [UserName.create],
  /// which performs the final username validation before creating
  /// the Value Object.
  static UserName generate({required String name}) {
    // Validate and clean the name before using it as the
    // username prefix.
    //
    // This prevents invalid names from being used to generate
    // invalid usernames.
    final cleanedFirstName = NameValidator.validateOrThrow(
      name: name,
      nameType: 'first name be used in generate username.',
    );

    // Select one separator randomly from the supported symbols.
    final symbol = _symbols.randomItem();

    // Generate a random numeric suffix.
    //
    // The generated value is a String so that numeric formatting,
    // including possible leading zeros, is preserved.
    final number = RandomDigitsGenerator.generate();

    // Combine the validated name, random symbol, and random digits
    // into the candidate username.
    final userName = '$cleanedFirstName$symbol$number';

    // Create the final UserName Value Object.
    //
    // UserName.create() performs the final validation of the complete
    // username before allowing it to enter the Domain.
    return UserName.create(value: userName);
  }
}
