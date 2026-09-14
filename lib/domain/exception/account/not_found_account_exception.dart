class NotFoundAccountException implements Exception {
  const NotFoundAccountException(this.message);
  final String message;
  @override
  String toString() => message;
}
