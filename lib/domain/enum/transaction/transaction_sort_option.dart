enum TransactionSortOption {
  newest,
  oldest;

  String get displayName {
    switch (this) {
      case newest:
        return "Newest";
      case oldest:
        return "Oldest";
    }
  }
}
