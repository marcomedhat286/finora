class NotValidIdenticalUserId implements Exception {
  const NotValidIdenticalUserId(this._message);
  final String _message;
  @override
  String toString() => _message;
}
