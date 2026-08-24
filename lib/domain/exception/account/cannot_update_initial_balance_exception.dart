class CannotUpdateInitialBalanceException implements Exception {
  final String message;
  const CannotUpdateInitialBalanceException({required this.message});

  @override
  String toString() => message;
}
