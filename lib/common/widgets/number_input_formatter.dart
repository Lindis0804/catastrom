import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue;
    }

    final rawText = newValue.text;
    final inputText = rawText.replaceAll(',', '');
    final sanitized = inputText.replaceAll(RegExp(r'[^0-9.]'), '');

    if (sanitized.isEmpty) {
      return oldValue;
    }

    final parts = sanitized.split('.');
    if (parts.length > 2) {
      return oldValue;
    }

    final integerPart = parts.first.isEmpty ? '0' : parts.first;
    final decimalPart = parts.length == 2 ? parts[1] : '';

    if (decimalPart.length > 3) {
      return oldValue;
    }

    final intValue = int.tryParse(integerPart);
    if (intValue == null) {
      return oldValue;
    }

    final formattedInteger = NumberFormat('#,##0', 'en_US').format(intValue);
    final hasDecimalSeparator = sanitized.contains('.') && decimalPart.isEmpty;
    final formattedText = hasDecimalSeparator
        ? '$formattedInteger.'
        : (decimalPart.isEmpty
            ? formattedInteger
            : '$formattedInteger.$decimalPart');

    final caretOffset = newValue.selection.baseOffset;
    final safeCaret = caretOffset.clamp(0, formattedText.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: safeCaret),
    );
  }
}

// Utility class để lấy giá trị số thực từ text đã format
class NumberUtils {
  static double? getNumericValue(String formattedText) {
    if (formattedText.isEmpty) return null;

    final cleanText = formattedText.replaceAll(',', '');
    return double.tryParse(cleanText);
  }

  static String formatNumberDisplay(dynamic value) {
    if (value == null) return '';

    double? numValue;
    if (value is String) {
      numValue = double.tryParse(value.replaceAll(',', ''));
    } else if (value is num) {
      numValue = value.toDouble();
    }

    if (numValue == null) return '';

    final formatter = NumberFormat('#,##0.###', 'en_US');
    return formatter.format(numValue);
  }
}
