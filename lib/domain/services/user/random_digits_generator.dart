import 'dart:math';

/// Generates a random sequence of numeric digits.
///
/// [RandomDigitsGenerator] is responsible for generating the numeric
/// suffix used by the username generation process.
///
/// The generated value:
///
/// - Contains digits only (`0-9`).
/// - Has a random length between 1 and 10 digits.
/// - May contain leading zeros.
/// - Is returned as a [String] because the generated digits are part
///   of an identifier/username, not a mathematical number.
///
/// Example outputs:
///
/// ```text
/// 7
/// 42
/// 003
/// 92817
/// 1045839201
/// ```
///
/// The generated digits can then be combined with a user's name and
/// a separator to create a complete username:
///
/// ```text
/// firstName + separator + randomDigits
///
/// marco + @ + 472
///       ↓
/// marco@472
/// ```
abstract final class RandomDigitsGenerator {
  /// Maximum number of digits that can be generated.
  ///
  /// The actual generated length is randomly selected from:
  ///
  /// ```text
  /// 1 → 10
  /// ```
  ///
  /// This value represents the maximum length, not the exact length.
  static const int _maxDigitsLength = 10;

  /// Random number generator used to select both:
  ///
  /// - The total number of digits.
  /// - Each individual digit.
  ///
  /// A single [Random] instance is reused instead of creating a new
  /// instance every time [generate] is called.
  static final Random _random = Random();

  /// Available numeric characters.
  ///
  /// Each character is selected independently when generating
  /// the random digit sequence.
  static const String _digits = '0123456789';

  /// Generates a random numeric String with a length between 1 and 10.
  ///
  /// The generation process is:
  ///
  /// ```text
  /// Choose random length
  ///        ↓
  /// Generate a random digit for each position
  ///        ↓
  /// Store digits in a List<String>
  ///        ↓
  /// Join the digits
  ///        ↓
  /// Return String
  /// ```
  ///
  /// Example:
  ///
  /// ```text
  /// Random length = 4
  ///
  /// Position 1 → 7
  /// Position 2 → 2
  /// Position 3 → 0
  /// Position 4 → 5
  ///
  /// Result → "7205"
  /// ```
  static String generate() {
    // Generate a random length between 1 and _maxDigitsLength.
    //
    // nextInt(10) produces values from 0 to 9.
    // Adding 1 changes the range to:
    //
    // 1 → 10
    final length = _random.nextInt(_maxDigitsLength) + 1;

    // Generate one random digit for each position.
    //
    // _random.nextInt(_digits.length) generates an index between
    // 0 and 9, which is then used to select a character from
    // the _digits String.
    final List<String> digits = List.generate(
      length,
      (int index) => _digits[_random.nextInt(_digits.length)],
    );

    // Combine all generated digits into a single String.
    //
    // String is intentionally returned instead of int so that
    // leading zeros are preserved.
    //
    // Example:
    //
    // ["0", "4", "7"] → "047"
    return digits.join();
  }
}
