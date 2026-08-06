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
  List<int> ids = transaction.categoryList ?? [];
  List<String> names = transaction.categories;
  int length = ids.length < names.length ? ids.length : names.length;
  return List.generate(
    length,
    (i) => Category(id: ids[i], code: '', description: names[i]),
  );
}

void showAddTransactionSheet(
  BuildContext context, {
  Transaction? initialTransaction,
  required ValueChanged<Transaction> onSave,
}) {
  bool isEditing = initialTransaction != null;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      TextEditingController amountController = TextEditingController(
        text: isEditing ? initialTransaction.transAmount.toString() : null,
      );
      TextEditingController descriptionController = TextEditingController(
        text: isEditing ? initialTransaction.description : null,
      );
      DateTime? selectedDate = isEditing ? initialTransaction.transDate : null;
      List<Category> selectedCategories =
          isEditing ? _categoriesFromTransaction(initialTransaction) : [];
      String amountErrMsg = '';

      return StatefulBuilder(
        builder: (context, setModalState) {
          void handleSave() {
            final normalizedAmount =
                normalizeAmountValue(amountController.text);
            final bool isAmountValid = normalizedAmount != null;

            if (!isAmountValid || selectedDate == null) {
              setModalState(() {
                amountErrMsg = isAmountValid ? '' : 'Số tiền không hợp lệ';
              });
              return;
            }
            onSave(
              Transaction(
                id: isEditing ? initialTransaction.id : null,
                description: descriptionController.text,
                transAmount: normalizedAmount,
                transDate: selectedDate!,
                categoryList: selectedCategories.map((c) => c.id).toList(),
                categories:
                    selectedCategories.map((c) => c.description).toList(),
              ),
            );
            Navigator.of(context).pop();
          }

          Widget saveButtons = isEditing
              ? Row(
                  children: [
                    Expanded(
                      child: CustomOutlinedButton(
                        text: 'Cancel',
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: BigCustomButton(
                        text: 'OK',
                        onPressed: handleSave,
                      ),
                    ),
                  ],
                )
              : BigCustomButton(
                  text: 'Lưu',
                  onPressed: handleSave,
                );

          return Padding(
            padding: EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_back),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isEditing ? 'Sửa giao dịch' : 'Add transaction',
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Số tiền',
                    placeholder: 'Nhập số tiền',
                    controller: amountController,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    errorMessage: amountErrMsg,
                    onChanged: (value) {
                      setModalState(() {
                        final normalizedValue = normalizeAmountValue(value);
                        amountErrMsg =
                            (value.trim().isNotEmpty && normalizedValue == null)
                                ? 'Số tiền không hợp lệ'
                                : '';
                      });
                    },
                  ),
                  CustomDatePicker(
                    label: 'Ngày giao dịch',
                    placeholder: 'Chọn ngày',
                    dateFormat: 'dd/MM/yyyy HH:mm',
                    initialDate: selectedDate,
                    onDateChanged: (date) {
                      setModalState(() {
                        selectedDate = date;
                      });
                    },
                  ),
                  const Text(
                    'Danh mục',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 8),
                  CategorySearchPicker(
                    selectedCategories: selectedCategories,
                    onChanged: (categories) {
                      setModalState(() {
                        selectedCategories = categories;
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  CustomTextArea(
                    label: 'Mô tả',
                    placeholder: 'Nhập mô tả giao dịch',
                    controller: descriptionController,
                    minLines: 2,
                    maxLines: 4,
                  ),
                  const SizedBox(height: 8),
                  saveButtons,
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
