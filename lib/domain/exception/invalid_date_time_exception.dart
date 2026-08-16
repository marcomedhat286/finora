final class InvalidDateTimeException implements Exception {
  final String message;

  const InvalidDateTimeException(this.message);

  @override
  String toString() => message;
}
