bool validateUserName(String name) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
  return regex.hasMatch(name);
}

bool validateName(String name) {
  RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
  return regex.hasMatch(name);
}

const List<String> _passwordSpecialChars = [
  '!',
  '@',
  '#',
  '\$',
  '%',
  '^',
  '&',
  '*',
  '(',
  ')',
  '-',
  '_',
  '=',
  '+',
  '[',
  ']',
  '{',
  '}',
  '\\',
  '|',
  ';',
  ':',
  "'",
  '"',
  ',',
  '.',
  '<',
  '>',
  '/',
  '?',
  '~',
  '`',
];

bool validatePassword(String password) {
  if (password.length < 8) {
    return false;
  }
  final String escapedSpecials =
      _passwordSpecialChars.map(RegExp.escape).join();
  final RegExp charsetRegex = RegExp('^[a-zA-Z0-9$escapedSpecials]+\$');
  if (!charsetRegex.hasMatch(password)) {
    return false;
  }
  final bool hasLower = RegExp(r'[a-z]').hasMatch(password);
  final bool hasUpper = RegExp(r'[A-Z]').hasMatch(password);
  final bool hasDigit = RegExp(r'\d').hasMatch(password);
  final bool hasSpecial = _passwordSpecialChars.any(password.contains);
  return hasLower && hasUpper && hasDigit && hasSpecial;
}

bool validatePhoneNumber(String phoneNumber) {
  RegExp regex = RegExp(r'^\d{9,12}$');
  if (regex.hasMatch(phoneNumber)) {
    return true;
  }
  return false;
}

double? normalizeAmountValue(String amount) {
  if (amount.trim().isEmpty) {
    return null;
  }

  String cleaned = amount.trim().replaceAll(RegExp(r'\s+'), '');
  cleaned = cleaned.replaceAll(RegExp(r'[^0-9,\.]'), '');

  if (cleaned.isEmpty) {
    return null;
  }

  if (cleaned.contains(',') && cleaned.contains('.')) {
    final lastComma = cleaned.lastIndexOf(',');
    final lastDot = cleaned.lastIndexOf('.');

    if (lastDot > lastComma) {
      cleaned = cleaned.replaceAll(',', '');
    } else {
      cleaned = cleaned.replaceAll('.', '');
      cleaned = cleaned.replaceAll(',', '.');
    }
  } else if (cleaned.contains(',')) {
    cleaned = cleaned.replaceAll(',', '');
  }

  if (cleaned.contains('.')) {
    final parts = cleaned.split('.');
    if (parts.length > 2) {
      return null;
    }
    if (parts[1].length > 3) {
      return null;
    }
  }

  final value = double.tryParse(cleaned);
  if (value == null || value <= 0) {
    return null;
  }

  return value;
}

bool validateAmount(String amount) {
  final normalized = normalizeAmountValue(amount);
  return normalized != null && normalized > 0;
}
