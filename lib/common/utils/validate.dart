bool validateUserName(String name) {
  RegExp regex = RegExp(r'^[a-zA-Z0-9]+$');
  return regex.hasMatch(name);
}

bool validateName(String name) {
  RegExp regex = RegExp(r'^[\p{L}\s]+$', unicode: true);
  return regex.hasMatch(name);
}

const List<String> _passwordSpecialChars = [
  '!', '@', '#', '\$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+',
  '[', ']', '{', '}', '\\', '|', ';', ':', "'", '"', ',', '.', '<', '>',
  '/', '?', '~', '`',
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

bool validateAmount(String amount) {
  RegExp regex = RegExp(r'^\d+(\.\d{1,2})?$');
  if (!regex.hasMatch(amount)) {
    return false;
  }
  return double.parse(amount) > 0;
}
