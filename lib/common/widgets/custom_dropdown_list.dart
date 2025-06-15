import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final List<String> items;
  final ValueChanged<String> onItemChanged;
  final String selectedItem;
  const CustomDropdownButton(
      {required this.items,
      required this.onItemChanged,
      required this.selectedItem,
      super.key});
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      items: items.map(
        (String e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        },
      ).toList(),
      onChanged: (String? newValue) {
        onItemChanged.call(newValue!);
      },
      value: selectedItem,
    );
  }
}
