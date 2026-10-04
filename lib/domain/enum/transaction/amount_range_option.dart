enum AmountRangeOptions {
  any,
  from1to50,
  from50to200,
  from200to500,
  moreThan500;

  String get displayRange {
    switch (this) {
      case any:
        return "Any";
      case from1to50:
        return "1-50 \$";
      case from50to200:
        return "50-200 \$";
      case from200to500:
        return "200-500 \$";
      case moreThan500:
        return "500+ \$";
    }
  }
}
