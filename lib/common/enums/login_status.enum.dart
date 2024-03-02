enum LoginStatus {
  initialize,
  forgotPassword,
  login,
  moveToSignUp,
  moveToHome;

  bool get isForgotPassword => this == LoginStatus.forgotPassword;
}
