# Error Dialog Utility

This utility provides consistent error handling across the app with user-friendly error messages.

## Usage

### Basic Error Dialog

```dart
import 'package:template/common/widgets/error_dialog_utils.dart';

// Show a simple error dialog
ErrorDialogUtils.showErrorDialog(
  context: context,
  errorMessage: 'Something went wrong',
  title: 'Error',
  isEditMode: false,
);
```

### Error Dialog with Retry

```dart
// Show error dialog with retry functionality
ErrorDialogUtils.showErrorDialog(
  context: context,
  errorMessage: 'Failed to save data',
  title: 'Save Error',
  isEditMode: true,
  onRetry: () {
    // Retry logic here
    _saveData();
  },
);
```

### Error Toast Only

```dart
// Show just a toast notification
ErrorDialogUtils.showErrorToast(
  context: context,
  message: 'Quick error message',
  isEditMode: false,
);
```

### Success Toast

```dart
// Show success toast notification
ErrorDialogUtils.showSuccessToast(
  context: context,
  message: 'Operation completed successfully!',
);
```

### Full Error Feedback (Toast + Dialog)

```dart
// Show both toast and dialog for comprehensive feedback
ErrorDialogUtils.showErrorFeedback(
  context: context,
  errorMessage: apiErrorMessage,
  title: 'Operation Failed',
  isEditMode: true,
  onRetry: () => _retryOperation(),
  showToast: true,
  barrierDismissible: false,
);
```

## Error Message Parsing

The utility automatically parses common error types and shows user-friendly messages:

-   **Database errors**: "Hệ thống đang bảo trì. Vui lòng thử lại sau."
-   **Authentication errors**: "Phiên đăng nhập đã hết hạn. Vui lòng đăng nhập lại."
-   **Network errors**: "Lỗi kết nối mạng. Vui lòng kiểm tra internet và thử lại."
-   **Timeout errors**: "Kết nối quá chậm. Vui lòng thử lại."
-   **Permission errors**: "Bạn không có quyền thực hiện thao tác này."
-   **Validation errors**: "Thông tin nhập vào không hợp lệ. Vui lòng kiểm tra lại."
-   **Server errors**: "Lỗi máy chủ. Vui lòng thử lại sau."
-   **Not found errors**: "Không tìm thấy dữ liệu yêu cầu."
-   **Conflict errors**: "Dữ liệu đã tồn tại hoặc xung đột."

## Parameters

### `showErrorDialog`

-   `context`: BuildContext (required)
-   `errorMessage`: String? - Raw error message to parse
-   `title`: String? - Custom dialog title
-   `isEditMode`: bool - Whether this is an edit operation (affects default messages)
-   `onRetry`: VoidCallback? - Retry function (shows retry button if provided)
-   `barrierDismissible`: bool - Whether dialog can be dismissed by tapping outside

### `showErrorToast`

-   `context`: BuildContext (required)
-   `message`: String? - Toast message
-   `isEditMode`: bool - Whether this is an edit operation
-   `duration`: Duration - How long toast should be shown

### `showErrorFeedback`

-   Combines all parameters from `showErrorDialog` and `showErrorToast`
-   `showToast`: bool - Whether to show toast along with dialog

## Examples in Different Contexts

### API Call Error Handling

```dart
try {
  await apiService.createTimeline(data);
  // Success handling
} catch (error) {
  ErrorDialogUtils.showErrorFeedback(
    context: context,
    errorMessage: error.toString(),
    title: 'Failed to Create Timeline',
    isEditMode: false,
    onRetry: () => _handleSave(),
  );
}
```

### BLoC Error State Handling

```dart
BlocConsumer<MyBloc, MyState>(
  listener: (context, state) {
    if (state.status == LoadingStatus.error) {
      ErrorDialogUtils.showErrorFeedback(
        context: context,
        errorMessage: state.errorMessage,
        title: 'Operation Failed',
        isEditMode: state.isEditMode,
        onRetry: () => context.read<MyBloc>().add(RetryEvent()),
      );
    }
  },
  // ...
)
```
