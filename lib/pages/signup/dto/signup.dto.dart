class SignUpUserDto {
  const SignUpUserDto(
      {required this.firstName,
      required this.lastName,
      required this.phoneNumber,
      required this.username,
      required this.password});
  final String firstName, lastName, phoneNumber, username, password;
  Map<String, String> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phoneNumber': phoneNumber,
      'username': username,
      'password': password
    };
  }
}
