import 'package:network/network.dart';

import '../entities/user.dart';

class UserDetailRequest extends GQLExecutor<User> {
  const UserDetailRequest(GQLClient client)
      : super(
          client: client,
          parser: const _UserDetailParser(),
        );
}

class _UserDetailParser extends GQLParser<User> {
  const _UserDetailParser();

  @override
  String get document => '''
    query userDetail {
      userDetail {
        id
        name
        email
        image
        about
      }
    }
  ''';

  @override
  GQLType get type => GQLType.query;

  @override
  User parse(Map<String, dynamic> json) {
    final dynamic user = json['userDetail'];
    return User.fromMap(user as Map<String, dynamic>);
  }
}
