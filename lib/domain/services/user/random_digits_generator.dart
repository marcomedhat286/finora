import 'dart:math';

///                     14/7
/// A utility responsible for generating a random numeric string.
///
/// This class is intended to create numeric suffixes that can be appended
/// to values such as usernames, identifiers, temporary labels, or any
/// other string requiring a lightweight random number sequence.
///
/// The generated value:
/// - Consists exclusively of decimal digits (`0-9`).
/// - Has a random length between **1** and **10** digits.
/// - Allows repeated digits.
/// - Is generated using a shared [Random] instance to avoid unnecessary
///   object allocations and improve performance.
///
/// Since this class only exposes static members, it cannot be instantiated.
abstract final class RandomDigitsGenerator {
  /// The upper limit for the number of digits that can be generated.
  ///
  /// The actual generated length is chosen randomly in the inclusive
  /// range of **1** to **10**.
  static const int _maxDigitsLength = 10;

  /// Shared pseudo-random number generator.
  ///
  /// A single reusable instance is intentionally kept for the lifetime
  /// of the application to:
  ///
  /// - Eliminate repeated object creation.
  /// - Improve performance.
  /// - Produce independent random values across successive calls.
  ///
  /// This generator is **not** intended for cryptographic or
  /// security-sensitive operations.
  static final Random _random = Random();

  /// Collection of characters available for building the random sequence.
  ///
  /// Each generated character is selected independently from this string,
  /// meaning:
  ///
  /// - Every digit has an equal probability of being selected.
  /// - Digits may appear multiple times.
  /// - The resulting string contains numeric characters only.
  static const String _digits = '0123456789';

  /// Generates a random numeric string.
  ///
  /// Generation process:
  ///
  /// 1. Randomly selects a length between **1** and [_maxDigitsLength].
  /// 2. Picks each digit independently from [_digits].
  /// 3. Concatenates all generated digits into a single string.
  ///
  /// Example outputs:
  ///
  /// ```text
  /// 7
  /// 483
  /// 00921
  /// 7145983021
  /// ```
  ///
  /// Every invocation produces a completely new random sequence.
  static String generate() {
    /// Randomly choose how many digits will be generated.
    ///
    /// Adding `1` converts the range produced by `nextInt()`
    /// from `0..9` into the desired range of `1..10`.
    final length = _random.nextInt(_maxDigitsLength) + 1;

    /// Build the numeric sequence one digit at a time.
    ///
    /// For every position:
    /// - A random index is selected.
    /// - The corresponding digit is retrieved from [_digits].
    /// - The digit is stored in the resulting list.
    final List<String> digits = List.generate(
      length,
      (int index) => _digits[_random.nextInt(_digits.length)],
    );

    /// Merge all generated digits into a single string
    /// and return the final numeric sequence.
    return digits.join();
  }
}
