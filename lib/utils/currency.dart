import 'package:intl/intl.dart';

class CustomCurrency {
  static NumberFormat currencyIdr() =>
      NumberFormat.compactCurrency(locale: 'id');
}

extension DynamicParsing on dynamic {
  String currencyValueFormat() {
    var formatter = NumberFormat("#,##0");
    return formatter.format(this);
  }
}