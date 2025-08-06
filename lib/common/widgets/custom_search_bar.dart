import 'package:flutter/material.dart';
import 'package:template/common/constants/colors.dart';

class CustomSearchBar extends StatefulWidget {
  final String hintText;
  final Function(String) onSearch;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? height;
  final double? borderRadius;
  final Function(String)? onChanged;

  const CustomSearchBar(
      {Key? key,
      this.hintText = 'Tìm kiếm',
      required this.onSearch,
      this.backgroundColor,
      this.iconColor,
      this.height = 50,
      this.borderRadius = 25,
      this.onChanged})
      : super(key: key);

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSearch() {
    if (_controller.text.isNotEmpty) {
      widget.onSearch(_controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Colors.grey[100],
        borderRadius: BorderRadius.circular(widget.borderRadius!),
        border: Border.all(color: Colors.black, width: 1),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              onChanged: widget.onChanged,
              controller: _controller,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) => _handleSearch(),
              cursorColor: CustomColors.primary,
              decoration: InputDecoration(
                isDense: true,
                hintText: widget.hintText,
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
              ),
            ),
          ),
          // GestureDetector(
          //   onTap: _handleSearch,
          //   child: Container(
          //     width: 50,
          //     height: 50,
          //     decoration: BoxDecoration(
          //       color: widget.iconColor ?? const Color(0xFF2B5F7F),
          //       shape: BoxShape.circle,
          //     ),
          //     child: const Icon(
          //       Icons.search,
          //       color: Colors.white,
          //       size: 24,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}

// Ví dụ sử dụng
class ExamplePage extends StatelessWidget {
  const ExamplePage({Key? key}) : super(key: key);

  void _onSearch(String query) {
    print('Searching for: $query');
    // Xử lý tìm kiếm ở đây
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomSearchBar(
              onSearch: _onSearch,
              hintText: 'Tìm kiếm',
            ),
            const SizedBox(height: 20),
            // Phần còn lại của UI
            const Text(
              'Lịch trình của tôi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            // Thêm các widget khác...
          ],
        ),
      ),
    );
  }
}
