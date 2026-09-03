import 'package:flutter/material.dart';
import 'package:template/common/utils/validate.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_text_area.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/data/models/payment/transaction.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_search_picker.dart';

List<Category> _categoriesFromTransaction(Transaction transaction) {
  final List<int> ids = transaction.categoryList ?? [];
  final List<String> names = transaction.categories;

  final int length = ids.length < names.length ? ids.length : names.length;

  return List.generate(
    length,
    (i) => Category(
      id: ids[i],
      code: '',
      description: names[i],
    ),
  );
}

Future<void> showAddTransactionSheet(
  BuildContext context, {
  Transaction? initialTransaction,
  required ValueChanged<Transaction> onSave,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(16),
      ),
    ),
    builder: (_) {
      return AddTransactionSheet(
        initialTransaction: initialTransaction,
        onSave: onSave,
      );
    },
  );
}

class AddTransactionSheet extends StatefulWidget {
  final Transaction? initialTransaction;
  final ValueChanged<Transaction> onSave;

  const AddTransactionSheet({
    super.key,
    this.initialTransaction,
    required this.onSave,
  });

  @override
  State<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends State<AddTransactionSheet> {
  late final TextEditingController _amountController;
  late final TextEditingController _descriptionController;

  DateTime? _selectedDate;
  List<Category> _selectedCategories = [];

  String _amountErrMsg = '';

  bool get _isEditing => widget.initialTransaction != null;

  @override
  void initState() {
    super.initState();

    final transaction = widget.initialTransaction;

    _amountController = TextEditingController(
      text: transaction?.transAmount.toString() ?? '',
    );

    _descriptionController = TextEditingController(
      text: transaction?.description ?? '',
    );

    _selectedDate = transaction?.transDate;

    if (transaction != null) {
      _selectedCategories = _categoriesFromTransaction(transaction);
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    _descriptionController.dispose();

    super.dispose();
  }

  void _handleSave() {
    final normalizedAmount = normalizeAmountValue(
      _amountController.text,
    );

    final bool isAmountValid = normalizedAmount != null;

    if (!isAmountValid || _selectedDate == null) {
      setState(() {
        _amountErrMsg = isAmountValid ? '' : 'Số tiền không hợp lệ';
      });

      return;
    }

    final transaction = Transaction(
      id: _isEditing ? widget.initialTransaction!.id : null,
      description: _descriptionController.text,
      transAmount: normalizedAmount,
      transDate: _selectedDate!,
      categoryList: _selectedCategories.map((category) => category.id).toList(),
      categories:
          _selectedCategories.map((category) => category.description).toList(),
    );

    widget.onSave(transaction);

    Navigator.of(context).pop();
  }

  void _handleAmountChanged(String value) {
    final normalizedValue = normalizeAmountValue(value);

    setState(() {
      _amountErrMsg = value.trim().isNotEmpty && normalizedValue == null
          ? 'Số tiền không hợp lệ'
          : '';
    });
  }

  void _handleDateChanged(DateTime date) {
    setState(() {
      _selectedDate = date;
    });
  }

  void _handleCategoriesChanged(List<Category> categories) {
    setState(() {
      _selectedCategories = categories;
    });
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
          bottom: keyboardHeight + 16,
        ),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 16),
              _buildAmountField(),
              _buildDatePicker(),
              _buildCategoryPicker(),
              const SizedBox(height: 8),
              _buildDescriptionField(),
              const SizedBox(height: 8),
              _buildSaveButtons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back),
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        const SizedBox(width: 8),
        Text(
          _isEditing ? 'Sửa giao dịch' : 'Add transaction',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildAmountField() {
    return FormTextField(
      label: 'Số tiền',
      placeholder: 'Nhập số tiền',
      controller: _amountController,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      errorMessage: _amountErrMsg,
      onChanged: _handleAmountChanged,
    );
  }

  Widget _buildDatePicker() {
    return CustomDatePicker(
      label: 'Ngày giao dịch',
      placeholder: 'Chọn ngày',
      dateFormat: 'dd/MM/yyyy HH:mm',
      initialDate: _selectedDate,
      onDateChanged: _handleDateChanged,
    );
  }

  Widget _buildCategoryPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Danh mục',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        CategorySearchPicker(
          selectedCategories: _selectedCategories,
          onChanged: _handleCategoriesChanged,
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return CustomTextArea(
      label: 'Mô tả',
      placeholder: 'Nhập mô tả giao dịch',
      controller: _descriptionController,
      minLines: 2,
      maxLines: 4,
    );
  }

  Widget _buildSaveButtons() {
    if (_isEditing) {
      return Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Cancel',
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: BigCustomButton(
              text: 'OK',
              onPressed: _handleSave,
            ),
          ),
        ],
      );
    }

    return BigCustomButton(
      text: 'Lưu',
      onPressed: _handleSave,
    );
  }
}
