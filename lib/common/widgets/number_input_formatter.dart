import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  final NumberFormat _formatter = NumberFormat('#,##0.###', 'en_US');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Nếu text rỗng, return ngay
    if (newValue.text.isEmpty) {
      return newValue;
    }

    // Loại bỏ tất cả ký tự không phải số và dấu chấm để lấy giá trị thực
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d.]'), '');

    // Nếu không có số nào, return old value
    if (digitsOnly.isEmpty) {
      return oldValue;
    }

    // Đảm bảo chỉ có một dấu chấm
    List<String> parts = digitsOnly.split('.');
    if (parts.length > 2) {
      digitsOnly = '${parts[0]}.${parts.sublist(1).join('')}';
    }

    // Validate số
    double? value = double.tryParse(digitsOnly);
    if (value == null) {
      return oldValue;
    }

    // Format hiển thị với dấu phẩy
    String formattedText;
    if (digitsOnly.contains('.')) {
      // Nếu có dấu chấm, format riêng phần nguyên và phần thập phân
      List<String> splitParts = digitsOnly.split('.');
      String integerPart = splitParts[0];
      String decimalPart = splitParts[1];

      // Format phần nguyên
      int? intValue = int.tryParse(integerPart);
      if (intValue != null) {
        String formattedInteger = NumberFormat('#,##0', 'en_US').format(intValue);
        formattedText = decimalPart.isEmpty ? '$formattedInteger.' : '$formattedInteger.$decimalPart';
      } else {
        formattedText = digitsOnly;
      }
    } else {
      // Chỉ có phần nguyên
      formattedText = NumberFormat('#,##0', 'en_US').format(value.toInt());
    }

    // Tính toán vị trí cursor
    int cursorOffset = newValue.selection.baseOffset;
    int commaCount = ','.allMatches(formattedText.substring(0,
        cursorOffset.clamp(0, formattedText.length))).length;
    int newCursorPosition = (cursorOffset + commaCount).clamp(0, formattedText.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: newCursorPosition),
    );
  }
}

// Utility class để lấy giá trị số thực từ text đã format
class NumberUtils {
  static double? getNumericValue(String formattedText) {
    if (formattedText.isEmpty) return null;

    // Loại bỏ dấu phẩy để lấy số thực
    String cleanText = formattedText.replaceAll(',', '');
    return double.tryParse(cleanText);
  }

  static String formatNumberDisplay(dynamic value) {
    if (value == null) return '';

    double? numValue;
    if (value is String) {
      numValue = double.tryParse(value);
    } else if (value is num) {
      numValue = value.toDouble();
    }

    if (numValue == null) return '';

    final formatter = NumberFormat('#,##0.###', 'en_US');
    return formatter.format(numValue);
  }
}
