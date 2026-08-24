enum ExpenseCategory {
  food('food', 'Food'),
  drink('drink', 'Drink'),
  shopping('shopping', 'Shopping'),
  housing('housing', 'Housing'),
  transportation('transportation', 'Transportation'),
  entertainment('entertainment', 'Entertainment'),
  health('health', 'Health'),
  education('education', 'Education'),
  other('other', 'Other');

  final String code;
  final String displayName;

  const ExpenseCategory(this.code, this.displayName);

  factory ExpenseCategory.fromCode(String code) {
    return ExpenseCategory.values.firstWhere(
      (e) => e.code == code,
      orElse: () => ExpenseCategory.other,
    );
  }
}
