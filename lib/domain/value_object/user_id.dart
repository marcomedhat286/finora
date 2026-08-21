class UserId {
  final String value;

  const UserId._(this.value);

  factory UserId.create(String value) {
    if (value.trim().isEmpty) {
      throw ArgumentError('UserId cannot be empty.');
    }
    return UserId._(value.trim());
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is UserId && other.value == value);
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => value;
}
