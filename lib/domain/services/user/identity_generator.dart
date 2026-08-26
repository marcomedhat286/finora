import 'package:uuid/uuid.dart';

/// Provides UUID-based identity generation for Domain objects.
///
/// [IdentityGenerator] is responsible only for generating unique
/// UUID v4 values.
///
/// It does not know anything about a specific Domain entity such as:
///
/// - User
/// - Account
/// - Transaction
///
/// This keeps identity generation independent from the objects that
/// consume those identities.
///
/// Example:
///
/// ```dart
/// final userId = IdentityGenerator.generateUuid();
/// final accountId = IdentityGenerator.generateUuid();
/// ```
///
/// The generated UUID can then be passed to the corresponding
/// Value Object for validation and conversion:
///
/// ```text
/// IdentityGenerator
///        │
///        ▼
///     UUID v4
///        │
///        ├──────────────┐
///        ▼              ▼
///     UserId        AccountId
///        │              │
///        ▼              ▼
///    Validator      Validator
///        │              │
///        ▼              ▼
/// Valid UserId    Valid AccountId
/// ```
///
/// Keeping generation and validation separate is intentional:
///
/// - [IdentityGenerator] → Generates an identity.
/// - Domain Validators → Verify that the identity is valid.
/// - Value Objects → Represent the validated identity.
abstract class IdentityGenerator {
  /// Shared UUID generator instance used to generate UUID v4 values.
  ///
  /// The instance is created once and reused for every generation
  /// instead of creating a new [Uuid] object on every call.
  static final Uuid _uuid = const Uuid();

  /// Generates a new UUID version 4.
  ///
  /// UUID v4 generates a randomly based identifier suitable for
  /// representing unique identities within the application.
  ///
  /// Example output:
  ///
  /// ```text
  /// 550e8400-e29b-41d4-a716-446655440000
  /// ```
  ///
  /// The method returns a [String] because the generated identity
  /// is later wrapped by the appropriate Domain Value Object.
  static String generateUuid() => _uuid.v4();
}
