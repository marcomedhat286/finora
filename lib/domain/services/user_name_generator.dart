import 'package:finora/domain/Extensions/random_item.dart';
import 'package:finora/domain/services/random_digits_generator.dart';
import 'package:finora/domain/validators/name_validator.dart';
import 'package:finora/domain/value_object/user_name.dart';

///                           14/7
/// Utility responsible for generating valid usernames that comply with
/// Finora's business rules.
///
/// A generated username follows the structure:
///
/// ```text
/// <first-name><separator><numeric-suffix>
/// ```
///
/// Where:
///
/// - **first-name** is validated using [NameValidator].
/// - **separator** is randomly chosen from the supported symbols
///   (`@`, `_`, or `-`).
/// - **numeric-suffix** is a randomly generated sequence containing
///   between **1** and **10** digits.
///
/// Example generated usernames:
///
/// ```text
/// marco@123
/// adam_7
/// john-98451
/// alice_0009
/// ```
///
/// Every generated username is returned as a validated [UserName]
/// value object, ensuring the caller never receives an invalid value.
abstract final class UserNameGenerator {
  /// Supported separator characters that may appear between
  /// the user's name and the numeric suffix.
  ///
  /// A separator is selected randomly for every generated username.
  static const List<String> _symbols = ['@', '_', '-'];

  /// Generates a valid random username from the supplied first name.
  ///
  /// Generation workflow:
  ///
  /// 1. Validate the provided first name.
  /// 2. Randomly select one supported separator.
  /// 3. Generate a random numeric suffix.
  /// 4. Concatenate all parts into a username.
  /// 5. Validate the final username by creating a [UserName]
  ///    value object.
  ///
  /// Throws:
  ///
  /// - Any exception raised by [NameValidator] if the supplied name
  ///   is invalid.
  /// - Any exception raised by [UserName.create] if the generated
  ///   username somehow violates the domain rules.
  static UserName generateUserName({required String name}) {
    /// Validate the supplied first name before using it to
    /// construct the username.
    ///
    /// This guarantees that every generated username starts
    /// with a valid name component.
    NameValidator.validateOrThrow(
      name: name,
      nameType: "first name be used in generate user name,",
    );

    /// Randomly choose one of the supported separator characters.
    final symbol = _symbols.randomItem();

    /// Generate a random numeric suffix.
    ///
    /// The returned value contains only digits and has a random
    /// length between 1 and 10 characters.
    final number = RandomDigitsGenerator.generate();

    /// Combine all generated components into the final username.
    final userName = "$name$symbol$number";

    /// Create and return a validated value object.
    ///
    /// Constructing the [UserName] acts as a final safety check,
    /// ensuring the generated value satisfies all domain constraints.
    return UserName.create(value: userName);
  }
}
