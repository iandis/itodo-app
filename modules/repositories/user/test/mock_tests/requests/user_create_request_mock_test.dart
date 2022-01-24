import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:user/src/requests/user_create.dart';
import 'package:user/user.dart';

import '../gql.mocks.dart';
import 'no_op_requests_mock.dart';

void main() {
  const String fakeId = 'fake-id';
  const String fakeName = 'fake-name';
  const String fakeEmail = 'fake-email';

  const UserCreateInput fakeInput = UserCreateInput(
    User(
      name: fakeName,
      email: fakeEmail,
    ),
  );

  final GQLClient fakeClient = MockGQLClient();

  final UserCreateRequest createRequest = UserCreateRequest(fakeClient);

  final UserRepository fakeRepository = UserRepository(
    createRequest: createRequest,
    updateRequest: const NoOpUserUpdateReq(),
    detailRequest: const NoOpUserDetailReq(),
  );

  group('Verify behavior of [UserCreateRequest]:', () {
    setUpAll(() {
      final MutationOptions fakeCreateOptions = MockMutationOptions(
        variables: fakeInput.variables,
      );

      const String fakeJsonResult = '''
        {
          "userCreate": {
            "id": "$fakeId",
            "name": "$fakeName",
            "email": "$fakeEmail"
          }
        }
      ''';

      when(fakeClient.mutate(fakeCreateOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });

    test(
      'When [execute] is called with name and email, '
      'then return a [User] with id, name, and email',
      () async {
        final User result = await fakeRepository.create(fakeInput);

        expect(result.id, equals(fakeId));
        expect(result.name, equals(fakeName));
        expect(result.email, equals(fakeEmail));
      },
    );
  });
}
