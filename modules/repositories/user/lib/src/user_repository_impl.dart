part of 'user_repository.dart';

class _UserRepositoryImpl implements UserRepository {
  const _UserRepositoryImpl({
    required UserCreateRequest createRequest,
    required UserUpdateRequest updateRequest,
    required UserDetailRequest detailRequest,
  })  : _createRequest = createRequest,
        _updateRequest = updateRequest,
        _detailRequest = detailRequest;

  factory _UserRepositoryImpl.create(GQLClient client) {
    return _UserRepositoryImpl(
      createRequest: UserCreateRequest(client),
      updateRequest: UserUpdateRequest(client),
      detailRequest: UserDetailRequest(client),
    );
  }

  final UserCreateRequest _createRequest;
  final UserUpdateRequest _updateRequest;
  final UserDetailRequest _detailRequest;

  @override
  Future<User> create(UserCreateInput input) {
    return _createRequest.execute(input.variables);
  }

  @override
  Future<User> update(UserUpdateInput input) {
    return _updateRequest.execute(input.variables);
  }

  @override
  Future<User> detail() {
    return _detailRequest.run();
  }
}
