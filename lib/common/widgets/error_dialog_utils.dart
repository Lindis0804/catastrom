import 'package:flutter/material.dart';
import 'package:template/common/constants/colors.dart';

class ErrorDialogUtils {
  /// Shows a user-friendly error dialog with parsed error messages
  static void showErrorDialog({
    required BuildContext context,
    String? errorMessage,
    String? title,
    bool isEditMode = false,
    VoidCallback? onRetry,
    bool barrierDismissible = false,
  }) {
    // Parse and clean up the error message
    String userFriendlyMessage = _parseErrorMessage(errorMessage, isEditMode);

    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red.shade600,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title ?? (isEditMode ? 'Lỗi cập nhật' : 'Lỗi xảy ra'),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.red.shade700,
                  ),
                ),
              ),
            ],
          ),
          content: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.maxFinite,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: SelectableText(
                      userFriendlyMessage,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red.shade800,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Text(
                      'Vui lòng thử lại sau hoặc liên hệ hỗ trợ nếu vấn đề vẫn tiếp tục.',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: TextButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              child: Text(
                'Đóng',
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (onRetry != null)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onRetry();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Thử lại',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  /// Shows a simple error toast notification
  static void showErrorToast({
    required BuildContext context,
    String? message,
    bool isEditMode = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message ?? (isEditMode ? 'Lỗi cập nhật' : 'Đã xảy ra lỗi'),
        ),
        backgroundColor: Colors.red.shade600,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Shows a success toast notification
  static void showSuccessToast({
    required BuildContext context,
    required String message,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                message,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  /// Shows both error dialog and toast for comprehensive error feedback
  static void showErrorFeedback({
    required BuildContext context,
    String? errorMessage,
    String? title,
    bool isEditMode = false,
    VoidCallback? onRetry,
    bool showToast = true,
    bool barrierDismissible = false,
  }) {
    // Show toast first for immediate feedback
    if (showToast) {
      showErrorToast(
        context: context,
        message: title ?? (isEditMode ? 'Lỗi cập nhật' : 'Đã xảy ra lỗi'),
        isEditMode: isEditMode,
        duration: const Duration(seconds: 2),
      );
    }

    // Then show detailed dialog
    showErrorDialog(
      context: context,
      errorMessage: errorMessage,
      title: title,
      isEditMode: isEditMode,
      onRetry: onRetry,
      barrierDismissible: barrierDismissible,
    );
  }

  /// Parse error messages to user-friendly text
  static String _parseErrorMessage(String? errorMessage, bool isEditMode) {
    if (errorMessage == null || errorMessage.isEmpty) {
      return isEditMode
          ? 'Không thể cập nhật. Vui lòng thử lại.'
          : 'Không thể thực hiện thao tác. Vui lòng thử lại.';
    }

    // Parse common error types and return user-friendly messages
    final lowercaseError = errorMessage.toLowerCase();

    if (lowercaseError.contains('table') &&
        lowercaseError.contains('doesn\'t exist')) {
      return 'Hệ thống đang bảo trì. Vui lòng thử lại sau.';
    } else if (lowercaseError
        .contains('query did not return a unique result')) {
      return 'Dữ liệu lịch trình bị trùng lặp. Vui lòng liên hệ hỗ trợ để khắc phục.';
    } else if (lowercaseError.contains('access token') ||
        lowercaseError.contains('authentication')) {
      return 'Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại.';
    } else if (lowercaseError.contains('network') ||
        lowercaseError.contains('connection')) {
      return 'Lỗi kết nối mạng. Vui lòng kiểm tra internet và thử lại.';
    } else if (lowercaseError.contains('timeout')) {
      return 'Kết nối quá chậm. Vui lòng thử lại.';
    } else if (lowercaseError.contains('permission') ||
        lowercaseError.contains('unauthorized')) {
      return 'Bạn không có quyền thực hiện thao tác này.';
    } else if (lowercaseError.contains('validation') ||
        lowercaseError.contains('invalid')) {
      return 'Thông tin nhập vào không hợp lệ. Vui lòng kiểm tra lại.';
    } else if (lowercaseError.contains('server error') ||
        lowercaseError.contains('500')) {
      return 'Lỗi máy chủ. Vui lòng thử lại sau.';
    } else if (lowercaseError.contains('not found') ||
        lowercaseError.contains('404')) {
      return 'Không tìm thấy dữ liệu yêu cầu.';
    } else if (lowercaseError.contains('conflict') ||
        lowercaseError.contains('409')) {
      return 'Dữ liệu đã tồn tại hoặc xung đột.';
    } else {
      // For any other technical errors, show a generic message
      return isEditMode
          ? 'Đã xảy ra lỗi khi cập nhật.'
          : 'Đã xảy ra lỗi không mong muốn.';
    }
  }
}
