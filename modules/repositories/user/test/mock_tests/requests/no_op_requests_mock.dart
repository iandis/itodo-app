import 'package:user/src/requests/user_create.dart';
import 'package:user/src/requests/user_detail.dart';
import 'package:user/src/requests/user_update.dart';

class NoOpUserCreateReq implements UserCreateRequest {
  const NoOpUserCreateReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}

class NoOpUserUpdateReq implements UserUpdateRequest {
  const NoOpUserUpdateReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}

class NoOpUserDetailReq implements UserDetailRequest {
  const NoOpUserDetailReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}
