extension StringValidate on String? {
  bool get isNullOrEmpty => this == null || this!.trim().isEmpty;
  bool isValid(RegExp regex) => regex.hasMatch(this!);
}
