import 'package:finora/domain/enum/account_type.dart';
import 'package:finora/domain/exception/invalid_account_type_exception.dart';

/// Provides domain-level validation and parsing for [AccountType] values.
///
/// [AccountTypeValidator] is responsible for converting a raw String
/// account type code into its corresponding [AccountType] enum value.
///
/// The validator normalizes the provided code before attempting to
/// match it by:
///
/// - Removing leading and trailing whitespace.
/// - Converting the code to lowercase.
///
/// This allows equivalent inputs such as:
///
/// ```text
/// "bank"
/// " Bank "
/// "BANK"
/// ```
///
/// to resolve to:
///
/// ```dart
/// AccountType.bank
/// ```
///
/// The validator only accepts codes that are explicitly defined by
/// [AccountType]. Any unsupported code results in an
/// [InvalidAccountTypeException].
///
/// Keeping this logic inside the Domain Layer ensures that the rules
/// for converting external account type codes into valid Domain
/// values are centralized and consistently applied throughout
/// the application.
///
/// [AccountTypeValidator] is stateless and exposes its behavior
/// through a static method.
abstract final class AccountTypeValidator {
  /// Validates an account type [code] and converts it into an
  /// [AccountType].
  ///
  /// The provided code is normalized before validation:
  ///
  /// 1. Leading and trailing whitespace is removed.
  /// 2. The code is converted to lowercase.
  /// 3. The normalized code is compared against the [AccountType.code]
  ///    values defined by the Domain.
  ///
  /// If a matching account type is found, the corresponding
  /// [AccountType] is returned.
  ///
  /// If no matching account type exists, an
  /// [InvalidAccountTypeException] is thrown.
  ///
  /// Example:
  ///
  /// ```dart
  /// final type = AccountTypeValidator.validateAndParse(
  ///   ' CREDIT_CARD ',
  /// );
  ///
  /// print(type);
  /// // Credit Card
  /// ```
  ///
  /// This method ensures that raw external String values cannot
  /// directly enter the Domain as an unsupported account type.
  static AccountType validateAndParse(String code) {
    // Normalize the incoming code before comparing it with
    // the predefined AccountType codes.
    //
    // Trimming removes unnecessary whitespace, while converting
    // to lowercase makes the comparison case-insensitive.
    final cleanCode = code.trim().toLowerCase();

    // Search for an AccountType whose code matches the
    // normalized input.
    //
    // If no matching value exists, throw a Domain-specific
    // exception instead of returning an invalid or null value.
    return AccountType.values.firstWhere(
      (type) => type.code == cleanCode,
      orElse: () => throw InvalidAccountTypeException(code),
    );
  }
}
