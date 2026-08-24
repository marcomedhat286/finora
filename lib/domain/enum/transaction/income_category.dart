enum IncomeCategory {
  salary('salary', 'Salary'),
  freelance('freelance', 'Freelance'),
  investments('investments', 'Investments'),
  gifts('gifts', 'Gifts'),
  other('other', 'other');

  final String code;
  final String displayName;

  const IncomeCategory(this.code, this.displayName);

  factory IncomeCategory.fromCode(String code) {
    return IncomeCategory.values.firstWhere(
      (e) => e.code == code,
      orElse: () => IncomeCategory.other,
    );
  }
}
