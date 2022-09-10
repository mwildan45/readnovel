import 'package:intl/intl.dart';

class CustomCurrency {
  static NumberFormat currencyIdr() =>
      NumberFormat.currency(locale: 'ID');
}

extension DynamicParsing on dynamic {
  String currencyValueFormat() {
    var formatter = NumberFormat("#,##0");
    return formatter.format(this);
  }
}