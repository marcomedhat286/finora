class NotFoundUserException implements Exception {
  const NotFoundUserException(this._message);
  final String _message;
  @override
  String toString() => _message;
}
