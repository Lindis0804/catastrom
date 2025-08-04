import 'package:flutter/material.dart';

// Model cho tagify items
class TagifyItem<T> {
  final String displayName;
  final T value;
  final String? code;
  final IconData? icon;

  TagifyItem({
    required this.displayName,
    required this.value,
    this.code,
    this.icon,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is TagifyItem<T> &&
              runtimeType == other.runtimeType &&
              value == other.value;

  @override
  int get hashCode => value.hashCode;
}

// Tagify Input Widget
class TagifyInput<T> extends StatefulWidget {
  final String? label;
  final String placeholder;
  final List<TagifyItem<T>> availableItems;
  final List<TagifyItem<T>>? selectedItems;
  final ValueChanged<List<TagifyItem<T>>>? onItemsChanged;
  final Color selectedTagColor;
  final Color unselectedTagColor;
  final Color backgroundColor;
  final Color borderColor;
  final Color labelColor;
  final double borderRadius;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final bool showBorder;
  final double tagBorderRadius;
  final bool enabled;
  final int? maxSelection;
  final bool showDropdown;
  final double maxDropdownHeight;
  final TextStyle? textStyle;
  final TextStyle? tagTextStyle;
  final bool allowCustomTags;
  final double height;

  const TagifyInput({
    super.key,
    this.label,
    required this.placeholder,
    required this.availableItems,
    this.selectedItems,
    this.onItemsChanged,
    this.selectedTagColor = const Color(0xFF2196F3),
    this.unselectedTagColor = const Color(0xFFE0E0E0),
    this.backgroundColor = Colors.white,
    this.borderColor = const Color(0xFFE0E0E0),
    this.labelColor = const Color(0xFF808080),
    this.borderRadius = 8.0,
    this.padding = const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    this.margin = const EdgeInsets.symmetric(vertical: 4),
    this.showBorder = true,
    this.tagBorderRadius = 16.0,
    this.enabled = true,
    this.maxSelection,
    this.showDropdown = true,
    this.maxDropdownHeight = 200.0,
    this.textStyle,
    this.tagTextStyle,
    this.allowCustomTags = false,
    this.height = 44,
  });

  @override
  State<TagifyInput<T>> createState() => _TagifyInputState<T>();
}

class _TagifyInputState<T> extends State<TagifyInput<T>> {
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<TagifyItem<T>> _selectedItems = [];
  List<TagifyItem<T>> _filteredItems = [];
  bool _showDropdown = false;
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _selectedItems = widget.selectedItems ?? [];
    _filteredItems = widget.availableItems;
    _focusNode.addListener(_onFocusChanged);
    _controller.addListener(_onTextChanged);
  }

  @override
  void didUpdateWidget(TagifyInput<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItems != oldWidget.selectedItems) {
      _selectedItems = widget.selectedItems ?? [];
    }
    if (widget.availableItems != oldWidget.availableItems) {
      _filteredItems = widget.availableItems;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _hideDropdown();
    super.dispose();
  }

  void _onFocusChanged() {
    if (_focusNode.hasFocus && widget.showDropdown) {
      _showDropdownMenu();
    } else {
      _hideDropdown();
    }
  }

  void _onTextChanged() {
    final query = _controller.text.toLowerCase();
    setState(() {
      _filteredItems = widget.availableItems
          .where((item) =>
              !_selectedItems.contains(item) &&
              item.displayName.toLowerCase().contains(query))
          .toList();
    });

    if (_focusNode.hasFocus && widget.showDropdown) {
      _showDropdownMenu();
    }
  }

  void _addItem(TagifyItem<T> item) {
    if (!widget.enabled) return;

    if (widget.maxSelection != null &&
        _selectedItems.length >= widget.maxSelection!) {
      return;
    }

    setState(() {
      if (!_selectedItems.contains(item)) {
        _selectedItems.add(item);
        _controller.clear();
        _filteredItems = widget.availableItems
            .where((availableItem) => !_selectedItems.contains(availableItem))
            .toList();
      }
    });

    widget.onItemsChanged?.call(_selectedItems);
    _focusNode.requestFocus();
  }

  void _removeItem(TagifyItem<T> item) {
    if (!widget.enabled) return;

    setState(() {
      _selectedItems.remove(item);
      _filteredItems = widget.availableItems
          .where((availableItem) => !_selectedItems.contains(availableItem))
          .toList();
    });

    widget.onItemsChanged?.call(_selectedItems);
  }

  void _showDropdownMenu() {
    _hideDropdown();

    if (_filteredItems.isEmpty) return;

    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
    setState(() {
      _showDropdown = true;
    });
  }

  void _hideDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    if (_showDropdown) {
      setState(() {
        _showDropdown = false;
      });
    }
  }

  OverlayEntry _createOverlayEntry() {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return OverlayEntry(
      builder: (context) => Material(
        type: MaterialType.transparency,
        child: Stack(
          children: [
            // Background overlay che toàn màn hình với barrier
            Positioned.fill(
              child: ModalBarrier(
                dismissible: true,
                onDismiss: _hideDropdown,
                color: Colors.black.withValues(alpha: 0.5),
              ),
            ),
            // Dropdown container được căn giữa màn hình
            Center(
              child: Material(
                type: MaterialType.card,
                elevation: 16, // Tăng elevation để đảm bảo hiển thị trên cùng
                borderRadius: BorderRadius.circular(widget.borderRadius),
                child: Container(
                  width: screenWidth * 0.9, // 90% chiều rộng màn hình
                  constraints: BoxConstraints(
                    maxHeight: widget.maxDropdownHeight + 100, // Tăng chiều cao cho header
                    maxWidth: 400, // Giới hạn chiều rộng tối đa
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(widget.borderRadius),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Header với title
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(widget.borderRadius),
                            topRight: Radius.circular(widget.borderRadius),
                          ),
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Text(
                              'Chọn mục',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            const Spacer(),
                            Material(
                              type: MaterialType.transparency,
                              child: InkWell(
                                onTap: _hideDropdown,
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  padding: const EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.close,
                                    size: 20,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Search input field
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: TextField(
                          controller: _controller,
                          autofocus: true,
                          style: widget.textStyle ?? const TextStyle(fontSize: 14),
                          decoration: InputDecoration(
                            hintText: 'Tìm kiếm...',
                            hintStyle: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 14,
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: widget.borderColor),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: widget.borderColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                              borderSide: BorderSide(color: widget.selectedTagColor, width: 2),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                            isDense: true,
                            filled: true,
                            fillColor: Colors.grey[50],
                          ),
                        ),
                      ),
                      // List items
                      Flexible(
                        child: _filteredItems.isEmpty
                            ? Container(
                                padding: const EdgeInsets.all(24),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.search_off,
                                      size: 48,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Không có kết quả',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              )
                            : Container(
                                constraints: BoxConstraints(
                                  maxHeight: widget.maxDropdownHeight,
                                ),
                                child: ListView.separated(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  itemCount: _filteredItems.length,
                                  separatorBuilder: (context, index) => Divider(
                                    height: 1,
                                    color: Colors.grey[200],
                                  ),
                                  itemBuilder: (context, index) {
                                    final item = _filteredItems[index];
                                    return Material(
                                      type: MaterialType.transparency,
                                      child: InkWell(
                                        onTap: () {
                                          _addItem(item);
                                          _hideDropdown();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                            vertical: 12,
                                          ),
                                          child: Row(
                                            children: [
                                              if (item.icon != null) ...[
                                                Icon(
                                                  item.icon,
                                                  size: 20,
                                                  color: widget.selectedTagColor,
                                                ),
                                                const SizedBox(width: 12),
                                              ],
                                              Expanded(
                                                child: Text(
                                                  item.displayName,
                                                  style: widget.textStyle ??
                                                      const TextStyle(fontSize: 14),
                                                ),
                                              ),
                                              Icon(
                                                Icons.add_circle_outline,
                                                color: widget.selectedTagColor,
                                                size: 20,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null) ...[
            _buildLabel(),
            const SizedBox(height: 8),
          ],
          _buildInputContainer(),
        ],
      ),
    );
  }

  Widget _buildLabel() {
    String labelText = widget.label!;
    if (widget.maxSelection != null) {
      labelText += ' (${_selectedItems.length}/${widget.maxSelection})';
    }

    return Text(
      labelText,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: widget.enabled ? widget.labelColor : widget.labelColor.withValues(alpha: 0.6),
      ),
    );
  }

  Widget _buildInputContainer() {
    return Container(
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.enabled ? widget.backgroundColor : widget.backgroundColor.withValues(alpha: 0.6),
        borderRadius: BorderRadius.circular(widget.borderRadius),
        border: widget.showBorder ? Border.all(
          color: _focusNode.hasFocus
              ? widget.selectedTagColor
              : widget.borderColor,
          width: _focusNode.hasFocus ? 2 : 1,
        ) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected tags section
          if (_selectedItems.isNotEmpty) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: _selectedItems.map((item) => _buildSelectedTag(item)).toList(),
            ),
            const SizedBox(height: 8),
          ],
          // Input field section with arrow
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  enabled: widget.enabled,
                  style: widget.textStyle ?? const TextStyle(fontSize: 14),
                  decoration: InputDecoration(
                    hintText: widget.placeholder,
                    hintStyle: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.zero,
                    isDense: true,
                  ),
                  onSubmitted: (value) {
                    if (widget.allowCustomTags && value.trim().isNotEmpty) {
                      // Logic để thêm custom tag nếu cần
                    }
                  },
                ),
              ),
              // Dropdown arrow
              if (widget.showDropdown)
                Icon(
                  _showDropdown ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  color: Colors.grey[600],
                  size: 20,
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedTag(TagifyItem<T> item) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: widget.selectedTagColor,
        borderRadius: BorderRadius.circular(widget.tagBorderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            Icon(
              item.icon,
              size: 12,
              color: Colors.white,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            item.displayName,
            style: widget.tagTextStyle ?? const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (widget.enabled) ...[
            const SizedBox(width: 4),
            GestureDetector(
              onTap: () => _removeItem(item),
              child: const Icon(
                Icons.close,
                size: 14,
                color: Colors.white,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Utility class để tạo TagifyItem dễ dàng
class TagifyItemBuilder {
  static List<TagifyItem<String>> fromStringList(List<String> items) {
    return items.map((item) => TagifyItem<String>(
      displayName: item,
      value: item,
    )).toList();
  }

  static List<TagifyItem<T>> fromMap<T>(Map<String, T> itemMap) {
    return itemMap.entries.map((entry) => TagifyItem<T>(
      displayName: entry.key,
      value: entry.value,
    )).toList();
  }

  static List<TagifyItem<T>> fromList<T>(
    List<T> items,
    String Function(T) getDisplayName,
  ) {
    return items.map((item) => TagifyItem<T>(
      displayName: getDisplayName(item),
      value: item,
    )).toList();
  }
}
