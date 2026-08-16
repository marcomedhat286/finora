import 'package:finora/domain/value_object/account_id.dart';
import 'package:uuid/uuid.dart';

/// Generates unique [AccountId] Value Objects for accounts.
///
/// [AccountIdGenerator] is responsible for creating new account
/// identifiers using UUID version 4.
///
/// Each generated identifier follows the Domain-defined format:
///
/// ```text
/// acc_<UUID v4>
/// ```
///
/// Example:
///
/// ```text
/// acc_550e8400-e29b-41d4-a716-446655440000
/// ```
///
/// The generated UUID is passed through [AccountId.fromUniqueString]
/// before being returned. This ensures that the generated identifier
/// is validated according to the same Domain rules used for manually
/// provided Account IDs.
///
/// This class is stateless and exposes its behavior through a static
/// method, so it does not need to be instantiated.
///
/// The UUID generation itself is delegated to the `uuid` package,
/// while the Domain remains responsible for representing and
/// validating the resulting identifier.
abstract final class AccountIdGenerator {
  /// Generates a new unique [AccountId].
  ///
  /// A UUID v4 is generated and combined with the required `acc_`
  /// prefix to create the complete Account ID.
  ///
  /// The resulting identifier is then passed to
  /// [AccountId.fromUniqueString], which validates the generated
  /// value before creating the [AccountId] Value Object.
  ///
  /// Example:
  ///
  /// ```dart
  /// final accountId = AccountIdGenerator.generateAccountId();
  ///
  /// print(accountId);
  /// // acc_550e8400-e29b-41d4-a716-446655440000
  /// ```
  static AccountId generateAccountId() {
    // Generate a random UUID version 4.
    //
    // UUID v4 is designed for randomly generated identifiers and
    // provides a very large identifier space, making accidental
    // collisions extremely unlikely.
    final number = const Uuid().v4();

    // Add the Domain-defined `acc_` prefix and pass the complete
    // identifier through the AccountId Value Object factory.
    //
    // AccountId.fromUniqueString() performs the final validation
    // before allowing the identifier to enter the Domain.
    return AccountId.fromUniqueString('acc_$number');
  }
}
