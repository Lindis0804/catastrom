enum LoginStatus {
  initialize,
  forgotPassword,
  login,
  callApiLoginFail,
  moveToSignUp,
  moveToHome;

  bool get isForgotPassword => this == LoginStatus.forgotPassword;
}
