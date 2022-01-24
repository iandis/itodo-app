import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:user/src/requests/user_update.dart';
import 'package:user/user.dart';

import '../gql.mocks.dart';
import 'no_op_requests_mock.dart';

void main() {
  const String fakeId = 'fake-id';
  const String fakeName = 'fake-name';
  const String fakeEmail = 'fake-email';

  const UserUpdateInput fakeInput = UserUpdateInput(
    User(
      name: fakeName,
      email: fakeEmail,
    ),
  );

  final GQLClient fakeClient = MockGQLClient();

  final UserUpdateRequest updateRequest = UserUpdateRequest(fakeClient);

  final UserRepository fakeRepository = UserRepository(
    createRequest: const NoOpUserCreateReq(),
    updateRequest: updateRequest,
    detailRequest: const NoOpUserDetailReq(),
  );

  group('Verify behavior of [UserUpdateRequest]:', () {
    setUpAll(() {
      final MutationOptions fakeUpdateOptions = MockMutationOptions(
        variables: fakeInput.variables,
      );

      const String fakeJsonResult = '''
        {
          "userUpdate": {
            "id": "$fakeId",
            "name": "$fakeName",
            "email": "$fakeEmail",
            "image": "fake-image",
            "about": "fake-about"
          }
        }
      ''';

      when(fakeClient.mutate(fakeUpdateOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });

    test(
      'When [execute] is called with name and email, '
      'then return a [User] with id, name, email, image, and about',
      () async {
        final User result = await fakeRepository.update(fakeInput);

        expect(result.id, equals(fakeId));
        expect(result.name, equals(fakeName));
        expect(result.email, equals(fakeEmail));
        expect(result.image, equals('fake-image'));
        expect(result.about, equals('fake-about'));
      },
    );
  });
}
