class LoginUser {
  const LoginUser(
      {required this.username, required this.password, this.rememberMe = true});
  final String username;
  final String password;
  final bool rememberMe;
  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'password': password,
      'rememberMe': rememberMe
    };
  }
}
