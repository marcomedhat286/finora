class TakenUserNameException implements Exception {
  final String message;
  const TakenUserNameException({required this.message});
  @override
  String toString() => message;
}
