enum DateRangeOptions {
  anyDate,
  last7Days,
  last14Days,
  thisMonth,
  lastMonth,
  customRange;

  String get displayName {
    switch (this) {
      case anyDate:
        return "Any Date";
      case last7Days:
        return "Last 7 Days";
      case last14Days:
        return "Last 14 Days";
      case thisMonth:
        return "This Month";
      case lastMonth:
        return "Last Month";
      case customRange:
        return "Custom Range";
    }
  }
}
