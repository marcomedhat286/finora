class InvalidMakeTransaction implements Exception {
  final String message;

  const InvalidMakeTransaction(this.message);

  /// Returns the exception message.
  @override
  String toString() => message;
}
