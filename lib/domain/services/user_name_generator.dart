import 'package:finora/domain/Extensions/random_item.dart';
import 'package:finora/domain/services/random_digits_generator.dart';
import 'package:finora/domain/validators/name_validator.dart';
import 'package:finora/domain/value_object/user_name.dart';

/// Generates valid and unique-looking usernames from a user's name.
///
/// [UserNameGenerator] is a Domain Service responsible for generating
/// usernames according to the application's business rules.
///
/// The generated username follows this structure:
///
/// ```text
/// <validated name><random separator><random digits>
/// ```
///
/// Example:
///
/// ```text
/// marco@482
/// adam_7
/// john-91342
/// ```
///
/// The generator does not accept the provided name blindly.
/// The name is first validated using [NameValidator] to ensure that
/// only a valid name can be used as the base of the username.
///
/// After validating the name:
///
/// 1. A random separator is selected from the supported symbols.
/// 2. A random numeric suffix is generated.
/// 3. The components are combined into a complete username.
/// 4. The final username is passed through [UserName.create].
///
/// Passing the generated value through [UserName.create] provides an
/// additional domain-level safety guarantee: the generated username
/// must satisfy all [UserName] validation rules before it can exist
/// as a valid Domain object.
///
/// This class is intentionally stateless and contains only static
/// behavior because username generation does not require maintaining
/// any object-specific state.
abstract final class UserNameGenerator {
  /// Supported separators that can appear between the name and
  /// the numeric part of the generated username.
  ///
  /// The available separators are:
  ///
  /// - `@`
  /// - `_`
  /// - `-`
  ///
  /// A separator is selected randomly every time a username is generated.
  static const List<String> _symbols = ['@', '_', '-'];

  /// Generates a valid [UserName] based on the provided [name].
  ///
  /// The [name] is first validated using [NameValidator].
  /// This ensures that the name used as the base of the username
  /// satisfies the application's name-related domain rules.
  ///
  /// After successful validation, the method:
  ///
  /// - Selects a random separator.
  /// - Generates a random numeric suffix.
  /// - Combines all components into a username string.
  /// - Creates a validated [UserName] Value Object.
  ///
  /// Example:
  ///
  /// ```dart
  /// final userName = UserNameGenerator.generate(
  ///   name: 'marco',
  /// );
  ///
  /// print(userName.value);
  /// // Possible output: marco@583
  /// ```
  ///
  /// Because both the input name and the final username are validated
  /// through Domain components, invalid data cannot silently enter
  /// the Domain.
  static UserName generate({required String name}) {
    // Validate the provided name before using it as the base
    // of the generated username.
    //
    // The validator also returns the cleaned/validated value,
    // which is used in the username generation process.
    final cleanedFirstName = NameValidator.validateOrThrow(
      name: name,
      nameType: 'first name be used in generate username.',
    );

    // Select a random separator from the supported username symbols.
    //
    // The randomItem extension encapsulates the logic of selecting
    // one item randomly from the list.
    final symbol = _symbols.randomItem();

    // Generate the numeric part of the username.
    //
    // RandomDigitsGenerator is responsible for generating the
    // required random sequence of digits according to its own
    // domain/service rules.
    final number = RandomDigitsGenerator.generate();

    // Combine the validated name, random separator, and random
    // numeric suffix into the final username string.
    final userName = '$cleanedFirstName$symbol$number';

    // Convert the generated String into a UserName Value Object.
    //
    // UserName.create performs the final domain validation,
    // ensuring that the generated value conforms to all username
    // business rules before returning it.
    return UserName.create(value: userName);
  }
}
