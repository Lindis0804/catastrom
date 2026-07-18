import 'package:flutter/material.dart';
import 'package:template/common/utils/validate.dart';
import 'package:template/common/widgets/custom_button.dart';
import 'package:template/common/widgets/custom_date_picker.dart';
import 'package:template/common/widgets/custom_text_area.dart';
import 'package:template/common/widgets/custom_textfield.dart';
import 'package:template/data/models/payment/category.model.dart';
import 'package:template/data/models/payment/transaction.model.dart';
import 'package:template/pages/payment_transactions/widgets/category_search_picker.dart';

void showAddTransactionSheet(
  BuildContext context, {
  required ValueChanged<Transaction> onSave,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (context) {
      TextEditingController amountController = TextEditingController();
      TextEditingController descriptionController = TextEditingController();
      DateTime? selectedDate;
      List<Category> selectedCategories = [];
      String amountErrMsg = '';

      return StatefulBuilder(
        builder: (context, setModalState) {
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
                      const Text(
                        'Add transaction',
                        style:
                            TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  FormTextField(
                    label: 'Số tiền',
                    placeholder: 'Nhập số tiền',
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    errorMessage: amountErrMsg,
                    onChanged: (value) {
                      setModalState(() {
                        String cleanValue = value.replaceAll(',', '');
                        amountErrMsg =
                            (cleanValue.isNotEmpty && !validateAmount(cleanValue))
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
                  BigCustomButton(
                    text: 'Lưu',
                    onPressed: () {
                      String amountText =
                          amountController.text.replaceAll(',', '');
                      bool isAmountValid =
                          amountText.isNotEmpty && validateAmount(amountText);
                      if (!isAmountValid || selectedDate == null) {
                        setModalState(() {
                          amountErrMsg =
                              isAmountValid ? '' : 'Số tiền không hợp lệ';
                        });
                        return;
                      }
                      onSave(
                        Transaction(
                          description: descriptionController.text,
                          transAmount: num.parse(amountText),
                          transDate: selectedDate!,
                          categoryList:
                              selectedCategories.map((c) => c.id).toList(),
                          categories: selectedCategories
                              .map((c) => c.description)
                              .toList(),
                        ),
                      );
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
