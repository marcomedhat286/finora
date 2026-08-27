import 'package:finora/domain/value_object/transaction/transaction_id.dart';
import 'package:uuid/uuid.dart';

/// Domain service responsible for generating unique [TransactionId] values.
///
/// This service generates a UUID v4 and adds the `tx_` prefix required by
/// the transaction ID format defined in [TransactionIdValidator].
///
/// The generated raw identifier is then passed through [TransactionId.create]
/// instead of constructing the value object directly. This guarantees that
/// even generated IDs pass through the same domain validation rules used for
/// externally provided IDs.
///
/// Example generated ID:
/// `tx_550e8400-e29b-41d4-a716-446655440000`
///
/// This class contains only static behavior and does not require an instance.
abstract final class TransactionIdGenerator {
  /// Reusable UUID generator used to create UUID v4 identifiers.
  ///
  /// Keeping one UUID generator instance avoids creating a new [Uuid]
  /// object every time a transaction ID is generated.
  static const Uuid _uuid = Uuid();

  /// Generates a new unique [TransactionId].
  ///
  /// The generation process is:
  ///
  /// 1. Generate a UUID v4.
  /// 2. Add the `tx_` prefix required by the domain.
  /// 3. Pass the complete identifier to [TransactionId.create].
  /// 4. Let [TransactionId] and its validator enforce the domain rules.
  ///
  /// Returns a fully validated [TransactionId] ready to be used inside
  /// the domain model.
  static TransactionId generateTransactionId() {
    // Generate a UUID v4 to provide a highly unique identifier.
    final number = _uuid.v4();

    // Add the transaction-specific prefix and let TransactionId perform
    // the final validation before returning the Value Object.
    return TransactionId.create("tx_$number");
  }
}
