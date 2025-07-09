import 'package:intl/intl.dart';

class NumberFormatter {
  static formatNumber(double number) {
    number.toStringAsFixed(2);
    final customFormatter = NumberFormat('#,##0', 'de_DE');
    String formatted = customFormatter.format(number).replaceAll('.', ',');
    // if (formatted.contains(',00')) {
    //   formatted = formatted.replaceAll(',00', '');
    // }
    return formatted;
  }
}
