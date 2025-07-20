import 'package:intl/intl.dart';

class StringUtils {
  static String formatNumber(String number) {
    double parsedNumber = parseFormattedStrToDouble(number);
    return NumberFormat.decimalPattern('en_US').format(parsedNumber);
  }

  static double parseFormattedStrToDouble(String str) {
    String strRes = str.replaceAll(',', '');
    return double.parse(strRes);
  }

  static bool isNullOrEmpty(String? str) {
    if (str == null || str.isEmpty) {
      return true;
    }
    return false;
  }
}
