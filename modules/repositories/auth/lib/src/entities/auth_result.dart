class AuthResult {
  const AuthResult({
    required this.id,
    required this.isNewUser,
    this.token,
    this.name,
    this.email,
    this.image,
  });

  final String id;

  final bool isNewUser;

  final String? token;
  final String? name;
  final String? email;
  final String? image;
}
