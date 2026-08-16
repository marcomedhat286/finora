class InvalidConvertingDouble implements Exception {
  final String message;

  const InvalidConvertingDouble(this.message);

  @override
  String toString() => message;
}
