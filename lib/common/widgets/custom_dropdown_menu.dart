import 'package:flutter/material.dart';

// DropdownMenuEntry labels and values for the first dropdown menu.
// enum OrderOption {
//   desc(EOrderBy.desc, Colors.pink),
//   asc(EOrderBy.asc, Colors.blue);

//   const OrderOption(this.label, this.color);
//   final EOrderBy label;
//   final Color color;
// }

class CustomDropdownMenu extends StatefulWidget {
  final void Function(String) onItemChanged;
  final String selectedItem;
  final List<String> items;
  const CustomDropdownMenu(
      {super.key,
      required this.onItemChanged,
      required this.selectedItem,
      required this.items});

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  final TextEditingController colorController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      initialSelection: widget.selectedItem,
      controller: colorController,
      // requestFocusOnTap is enabled/disabled by platforms when it is null.
      // On mobile platforms, this is false by default. Setting this to true will
      // trigger focus request on the text field and virtual keyboard will appear
      // afterward. On desktop platforms however, this defaults to true.
      requestFocusOnTap: true,
      onSelected: (String? value) {
        if (value != null) {
          widget.onItemChanged.call(value);
        }
      },
      dropdownMenuEntries: widget.items.map(
        (item) {
          return DropdownMenuEntry(value: item, label: item);
        },
      ).toList(),
    );
  }
}
