import 'dart:async';

import 'package:flutter/material.dart';
import 'package:template/api/payment/provider.dart';
import 'package:template/common/constants/colors.dart';
import 'package:template/common/utils/share_preferences.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_color.dart';

class CategorySearchPicker extends StatefulWidget {
  final List<Category> selectedCategories;
  final ValueChanged<List<Category>> onChanged;
  final String hintText;

  const CategorySearchPicker({
    super.key,
    required this.selectedCategories,
    required this.onChanged,
    this.hintText = 'Tìm danh mục...',
  });

  @override
  State<CategorySearchPicker> createState() => _CategorySearchPickerState();
}

class _CategorySearchPickerState extends State<CategorySearchPicker> {
  final TextEditingController _searchController = TextEditingController();
  List<Category> _suggestions = [];
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    _debounce?.cancel();
    if (value.trim().isEmpty) {
      setState(() => _suggestions = []);
      return;
    }
    _debounce = Timer(const Duration(milliseconds: 350), () async {
      try {
        String accessToken = await SharedPreferencesManager.getAccessToken();
        List<Category> results =
            await PaymentApiProvider(accessToken: accessToken)
                .getCategories(key: value.trim());
        if (!mounted) return;
        setState(() {
          _suggestions = results
              .where((c) =>
                  !widget.selectedCategories.any((s) => s.id == c.id))
              .toList();
        });
      } catch (_) {
        if (!mounted) return;
        setState(() => _suggestions = []);
      }
    });
  }

  void _selectCategory(Category category) {
    _searchController.clear();
    setState(() => _suggestions = []);
    widget.onChanged([...widget.selectedCategories, category]);
  }

  void _removeCategory(Category category) {
    widget.onChanged(
      widget.selectedCategories.where((c) => c.id != category.id).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: CustomColors.border),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.selectedCategories.isNotEmpty) ...[
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: widget.selectedCategories.map((category) {
                    Color color = categoryColor(category.description);
                    return Chip(
                      label: Text(
                        category.description,
                        style: TextStyle(
                          fontSize: 12,
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      backgroundColor: color.withValues(alpha: 0.12),
                      side: BorderSide(color: color),
                      deleteIconColor: color,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      visualDensity: VisualDensity.compact,
                      onDeleted: () => _removeCategory(category),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 6),
              ],
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  isDense: true,
                  border: InputBorder.none,
                  hintText: widget.hintText,
                ),
                onChanged: _onSearchChanged,
              ),
            ],
          ),
        ),
        if (_suggestions.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            constraints: const BoxConstraints(maxHeight: 180),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: CustomColors.border),
            ),
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: _suggestions.length,
              separatorBuilder: (context, idx) => const Divider(height: 1),
              itemBuilder: (context, idx) {
                Category category = _suggestions[idx];
                return ListTile(
                  dense: true,
                  title: Text(category.description),
                  onTap: () => _selectCategory(category),
                );
              },
            ),
          ),
      ],
    );
  }
}
