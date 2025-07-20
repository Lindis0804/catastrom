import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final String searchHint;
  final Function(String)? onChanged;
  const CustomSearchBar({super.key, required this.searchHint, this.onChanged});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: searchHint,
        suffixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }
}
