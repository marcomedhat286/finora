extension StringOperations on String {
  String capitalizeFirst() {
    if (isEmpty) return this;

    return this[0].toUpperCase() + substring(1);
  }

  String get initials {
    final words = trim().split(RegExp(r'\s+'));

    if (words.isEmpty) return '';
    if (words.length == 1) {
      return words[0].length >= 2
          ? words[0].substring(0, 2).toUpperCase()
          : words[0].toUpperCase();
    }

    final firstLetter = words[0][0];
    final secondLetter = words[1][0];

    return '$firstLetter$secondLetter'.toUpperCase();
  }
}
