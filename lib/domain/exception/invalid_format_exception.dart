final class InvalidFormatException implements Exception {
  final String message;

  const InvalidFormatException(this.message);

  @override
  String toString() => message;
}
