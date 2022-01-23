import 'package:network/network.dart';

import '../entities/user.dart';

class UserCreateRequest extends GQLExecutor<User> {
  const UserCreateRequest(GQLClient client)
      : super(
          client: client,
          parser: const _UserCreateParser(),
        );
}

class _UserCreateParser extends GQLParser<User> {
  const _UserCreateParser();

  @override
  String get document => r'''
    mutation userCreate($name: String!, $email: String!) {
      userCreate(userCreateInput: {
        name: $name,
        email: $email,
      }) {
        id
        name
        email
      }
    }
  ''';

  @override
  GQLType get type => GQLType.mutation;

  @override
  User parse(Map<String, dynamic> json) {
    final dynamic user = json['userCreate'];
    return User.fromMap(user as Map<String, dynamic>);
  }
}
