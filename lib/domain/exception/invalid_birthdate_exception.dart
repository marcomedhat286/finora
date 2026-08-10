class InvalidBirthdateException implements Exception {
  const InvalidBirthdateException({required this.message});
  final String message;
  @override
  String toString() => message;
}
