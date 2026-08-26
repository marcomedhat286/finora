class InvalidIncomeTypeException implements Exception {
  final String message;

  const InvalidIncomeTypeException(this.message);

  @override
  String toString() => message;
}
