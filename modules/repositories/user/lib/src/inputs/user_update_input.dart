import '../entities/user.dart';

class UserUpdateInput {
  const UserUpdateInput(this.user);

  final User user;

  Map<String, dynamic> get variables {
    return <String, dynamic>{
      'name': user.name,
      'email': user.email,
      'image': user.image,
      'about': user.about,
    };
  }
}
