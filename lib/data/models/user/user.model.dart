class User {
  final int id;
  final String firstName, lastName, phone, username;
  final String? avatar, cover;
  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.phone,
      required this.username,
      this.avatar,
      this.cover});
}
