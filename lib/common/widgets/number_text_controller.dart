import 'package:flutter/material.dart';
import 'package:template/common/widgets/number_input_formatter.dart';

class NumberTextEditingController extends TextEditingController {
  double? _numericValue;

  NumberTextEditingController({String? text, double? value}) : super(text: text) {
    if (value != null) {
      setNumericValue(value);
    }
  }

  // Getter để lấy giá trị số thực (dùng khi gọi API)
  double? get numericValue => _numericValue;

  // Setter để set giá trị số và format hiển thị
  void setNumericValue(double? value) {
    _numericValue = value;
    if (value != null) {
      text = NumberUtils.formatNumberDisplay(value);
    } else {
      text = '';
    }
  }

  @override
  set text(String newText) {
    // Khi text thay đổi, cập nhật numericValue
    if (newText.isEmpty) {
      _numericValue = null;
    } else {
      _numericValue = NumberUtils.getNumericValue(newText);
    }
    super.text = newText;
  }

  // Method để lấy giá trị clean (không có dấu phẩy) cho API
  String get cleanValue {
    if (_numericValue == null) return '';
    return _numericValue.toString();
  }
}
