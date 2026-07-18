import 'package:flutter/material.dart';

const List<Color> _categoryColorPalette = [
  Color(0xFF42A5F5),
  Color(0xFFAB47BC),
  Color(0xFFFFA726),
  Color(0xFF26A69A),
  Color(0xFFEF5350),
  Color(0xFF66BB6A),
  Color(0xFFFFCA28),
  Color(0xFF8D6E63),
  Color(0xFF5C6BC0),
  Color(0xFFEC407A),
];

Color categoryColor(String key) {
  return _categoryColorPalette[key.hashCode.abs() % _categoryColorPalette.length];
}
