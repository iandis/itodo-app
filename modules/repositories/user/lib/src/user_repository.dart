import 'package:network/network.dart';

import 'entities/user.dart';

import 'inputs/user_create_input.dart';
import 'inputs/user_update_input.dart';

import 'requests/user_create.dart';
import 'requests/user_detail.dart';
import 'requests/user_update.dart';

part 'user_repository_impl.dart';

abstract class UserRepository {
  const factory UserRepository({
    required UserCreateRequest createRequest,
    required UserUpdateRequest updateRequest,
    required UserDetailRequest detailRequest,
  }) = _UserRepositoryImpl;

  factory UserRepository.create(GQLClient client) = _UserRepositoryImpl.create;

  Future<User> create(UserCreateInput input);
  Future<User> update(UserUpdateInput input);
  Future<User> detail();
}
