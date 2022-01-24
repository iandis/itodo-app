import 'package:network/network.dart';

import '../entities/user.dart';

class UserUpdateRequest extends GQLExecutor<User> {
  const UserUpdateRequest(GQLClient client)
      : super(
          client: client,
          parser: const _UserUpdateParser(),
        );
}

class _UserUpdateParser extends GQLParser<User> {
  const _UserUpdateParser();

  @override
  String get document => r'''
    mutation userUpdate(
      $name: String,
      $email: String,
      $image: String,
      $about: String
    ) {
      userUpdate(userUpdateInput: {
        name: $name,
        email: $email,
        image: $image,
        about: $about
      }) {
        id
        name
        email
        image
        about
      }
    }
  ''';

  @override
  GQLType get type => GQLType.mutation;

  @override
  User parse(Map<String, dynamic> json) {
    final dynamic user = json['userUpdate'];
    return User.fromMap(user as Map<String, dynamic>);
  }
}
