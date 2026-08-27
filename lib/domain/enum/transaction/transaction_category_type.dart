/// Defines the contract that every transaction category type must follow.
///
/// A transaction category type provides two pieces of information:
///
/// - [code] → A stable identifier used internally for storage, comparison,
///   serialization, or database operations.
/// - [displayName] → A human-readable name intended to be displayed in the UI.
///
/// This interface allows different transaction category implementations
/// to share the same structure while keeping their concrete implementations
/// independent.
///
/// Example:
///
/// ```dart
/// class FoodCategory implements TransactionCategoryType {
///   @override
///   String get code => 'food';
///
///   @override
///   String get displayName => 'Food';
/// }
/// ```
///
/// Using an interface here keeps the Domain layer dependent on a contract
/// rather than on a specific implementation.
abstract interface class TransactionCategoryType {
  /// Unique/stable identifier representing this transaction category.
  ///
  /// This value should remain stable because it may be used for persistence,
  /// serialization, database storage, or category comparison.
  String get code;

  /// Human-readable name of the transaction category.
  ///
  /// This value is intended for presentation to the user and may differ
  /// from the internal [code].
  String get displayName;
}
