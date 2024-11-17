bool validateUserName(String name) {
  RegExp regex = RegExp(r'^(?=.*[a-zA-Z])(?=.*[\d])[a-zA-Z\d\s!@#$]{8,}$');
  if (regex.hasMatch(name)) {
    return true;
  }
  return false;
}

bool validateName(String name) {
  RegExp regex = RegExp(r'^[a-zA-Z\s!%\d]{1,}$');
  if (regex.hasMatch(name)) {
    return true;
  }
  return false;
}

bool validatePassword(String password) {
  // RegExp regex = RegExp(
  //     r'^(?=[^a-z]*[a-z])(?=.*[A-Z])(?=.*[!@#$])(?=\D*\d)[^:&.~\s]{5,20}$');
  // if (regex.hasMatch(password)) {
  //   return true;
  // }
  // return false;
  return true;
}

bool validatePhoneNumber(String phoneNumber) {
  RegExp regex = RegExp(r'^\d{9,12}$');
  if (regex.hasMatch(phoneNumber)) {
    return true;
  }
  return false;
}
