class InvalidProfileImageException implements Exception {
  final String message;
  InvalidProfileImageException(this.message);
  @override
  String toString() {
    return message;
  }
}
