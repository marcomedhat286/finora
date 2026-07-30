class InvalidConvertingDouble implements Exception {
  final String message;

  const InvalidConvertingDouble(this.message);

  /// Returns the exception message.
  @override
  String toString() => message;
}
