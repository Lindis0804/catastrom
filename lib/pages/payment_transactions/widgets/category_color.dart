import 'package:flutter/material.dart';

const List<Color> _categoryColorPalette = [
  Color(0xFF42A5F5), // blue 400
  Color(0xFFAB47BC), // purple 400
  Color(0xFFFFA726), // orange 400
  Color(0xFF26A69A), // teal 400
  Color(0xFFEF5350), // red 400
  Color(0xFF66BB6A), // green 400
  Color(0xFFFFCA28), // amber 400
  Color(0xFF8D6E63), // brown 400
  Color(0xFF5C6BC0), // indigo 400
  Color(0xFFEC407A), // pink 400
  Color(0xFF26C6DA), // cyan 400
  Color(0xFFD4E157), // lime 400
  Color(0xFFFF7043), // deep orange 400
  Color(0xFF78909C), // blue grey 400
];

// Assigns each category a color in first-seen order, so distinct categories
// shown together (e.g. the spending pie chart) never collide on the same
// color the way a hash-based lookup could.
final Map<String, Color> _assignedCategoryColors = {};

Color categoryColor(String key) {
  return _assignedCategoryColors.putIfAbsent(
    key,
    () => _categoryColorPalette[
        _assignedCategoryColors.length % _categoryColorPalette.length],
  );
}
