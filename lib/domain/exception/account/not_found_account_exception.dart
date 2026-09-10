class NotFoundAccountException implements Exception {
  const NotFoundAccountException(this._message);
  final String _message;
  @override
  String toString() => _message;
}
