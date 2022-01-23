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
  String get document => throw UnimplementedError();

  @override
  GQLType get type => GQLType.mutation;

  @override
  User parse(Map<String, dynamic> json) {
    throw UnimplementedError();
  }
}
