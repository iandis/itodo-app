import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:user/src/requests/user_create.dart';
import 'package:user/src/requests/user_detail.dart';
import 'package:user/src/requests/user_update.dart';

import 'package:user/user.dart';

import 'user_repository_test.mocks.dart';

@GenerateMocks([
  UserCreateRequest,
  UserUpdateRequest,
  UserDetailRequest,
])
void main() {
  const String fakeId = 'fake-id';
  const String fakeName = 'fake-name';
  const String fakeEmail = 'fake@email.com';

  const UserCreateInput fakeCreateInput = UserCreateInput(
    User(
      name: fakeName,
      email: fakeEmail,
    ),
  );

  const UserUpdateInput fakeUpdateInput = UserUpdateInput(
    User(
      name: fakeName,
      email: fakeEmail,
    ),
  );

  final UserCreateRequest fakeCreateReq = MockUserCreateRequest();
  final UserUpdateRequest fakeUpdateReq = MockUserUpdateRequest();
  final UserDetailRequest fakeDetailReq = MockUserDetailRequest();

  final UserRepository userRepository = UserRepository(
    createRequest: fakeCreateReq,
    updateRequest: fakeUpdateReq,
    detailRequest: fakeDetailReq,
  );

  group('Verify behavior of [UserRepository]:', () {
    setUpAll(() {
      when(fakeCreateReq.execute(fakeCreateInput.variables)).thenAnswer(
        // ignore: prefer_const_constructors
        (_) async => User(
          id: fakeId,
          name: fakeName,
          email: fakeEmail,
        ),
      );

      when(fakeUpdateReq.execute(fakeUpdateInput.variables)).thenAnswer(
        // ignore: prefer_const_constructors
        (_) async => User(
          id: fakeId,
          name: fakeName,
          email: fakeEmail,
        ),
      );

      when(fakeDetailReq.run()).thenAnswer(
        // ignore: prefer_const_constructors
        (_) async => User(
          id: fakeId,
          name: fakeName,
          email: fakeEmail,
          image: 'fake-image',
          about: 'fake-about',
        ),
      );
    });

    test(
      'When [create] is called with name and email, '
      'then return a [User] with id, name, and email',
      () async {
        final User user = await userRepository.create(fakeCreateInput);

        expect(user.id, equals(fakeId));
        expect(user.name, equals(fakeName));
        expect(user.email, equals(fakeEmail));
      },
    );

    test(
      'When [update] is called with name and email, '
      'then return a [User] with id, name, and email',
      () async {
        final User user = await userRepository.update(fakeUpdateInput);

        expect(user.id, equals(fakeId));
        expect(user.name, equals(fakeName));
        expect(user.email, equals(fakeEmail));
      },
    );

    test(
      'When [detail] is called, '
      'then return a [User] with id, name, email, image, and about',
      () async {
        final User user = await userRepository.detail();

        expect(user.id, equals(fakeId));
        expect(user.name, equals(fakeName));
        expect(user.email, equals(fakeEmail));
        expect(user.image, equals('fake-image'));
        expect(user.about, equals('fake-about'));
      },
    );
  });
}
