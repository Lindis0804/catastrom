import 'package:flutter/material.dart';

class ChipSearchDropdown extends StatefulWidget {
  @override
  _ChipSearchDropdownState createState() => _ChipSearchDropdownState();
}

class _ChipSearchDropdownState extends State<ChipSearchDropdown> {
  final List<String> _options = [
    'Nghệ An',
    'Quảng Nam',
    'Hà Tĩnh',
    'Đà Nẵng',
    'Quảng Ngãi'
  ];
  final List<String> _selected = [];
  String _searchText = '';

  void _openChipSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Full height
      builder: (context) {
        List<String> filteredOptions = _options;

        return StatefulBuilder(
          builder: (context, setModalState) {
            void _filterOptions(String text) {
              setModalState(() {
                _searchText = text;
                filteredOptions = _options
                    .where((item) =>
                        item.toLowerCase().contains(text.toLowerCase()))
                    .toList();
              });
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    autofocus: true,
                    decoration: const InputDecoration(
                      labelText: 'Tìm kiếm...',
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: _filterOptions,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: filteredOptions.map((option) {
                          final isSelected = _selected.contains(option);
                          return FilterChip(
                            label: Text(option),
                            selected: isSelected,
                            onSelected: (selected) {
                              setModalState(
                                () {
                                  if (selected) {
                                    _selected.add(option);
                                  } else {
                                    _selected.remove(option);
                                  }
                                },
                              );
                              setState(() {}); // Cập nhật giao diện bên ngoài
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    child: const Text('Xong'),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: _openChipSelector,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: _selected.isEmpty
                ? const Text("Chọn tỉnh...",
                    style: TextStyle(color: Colors.grey))
                : Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: _selected.map((item) {
                      return Chip(
                        label: Text(item),
                        deleteIcon: const Icon(Icons.cancel, size: 18),
                        onDeleted: () {
                          setState(() => _selected.remove(item));
                        },
                      );
                    }).toList(),
                  ),
          ),
        ),
      ],
    );
  }
}
