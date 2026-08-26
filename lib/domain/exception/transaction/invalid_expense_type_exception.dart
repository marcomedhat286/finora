class InvalidExpenseTypeException implements Exception {
  final String message;

  const InvalidExpenseTypeException(this.message);

  @override
  String toString() => message;
}
