import 'package:finora/domain/services/random_digits_generator.dart';

///                   15/7
/// Domain service responsible for generating account identifiers.
///
/// Every generated identifier follows the application's
/// predefined account ID format:
///
/// ```text
/// acc_<numeric-suffix>
/// ```
///
/// Where:
///
/// - `acc_` is a constant prefix identifying the value as an account ID.
/// - `<numeric-suffix>` is a randomly generated sequence of
///   digits produced by [RandomDigitsGenerator].
///
/// Example generated identifiers:
///
/// ```text
/// acc_7
/// acc_48291
/// acc_0034178
/// ```
///
/// ## Responsibilities
///
/// - Generate account identifiers using the application's
///   naming convention.
/// - Delegate numeric generation to [RandomDigitsGenerator].
/// - Centralize account ID generation logic in one place,
///   making future format changes easy to maintain.
///
/// ## Design Notes
///
/// This class does **not** guarantee global uniqueness.
/// It is responsible only for constructing identifiers that
/// follow the required business format.
///
/// If uniqueness is required, it should be enforced by the
/// appropriate persistence or application layer.
///
/// Since this class exposes only static behavior,
/// it cannot be instantiated.
abstract final class AccountIDGenerator {
  /// Generates an account identifier.
  ///
  /// Generation process:
  ///
  /// 1. Generate a random numeric suffix.
  /// 2. Prefix it with `"acc_"`.
  /// 3. Return the completed account identifier.
  ///
  /// Returns:
  ///
  /// A randomly generated account ID following the required
  /// application format.
  static String generateAccountId() {
    /// Generate the random numeric portion of the identifier.
    final number = RandomDigitsGenerator.generate();

    /// Assemble and return the final account identifier.
    return "acc_$number";
  }
}
