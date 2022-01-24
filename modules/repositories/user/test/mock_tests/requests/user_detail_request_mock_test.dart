import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:user/src/requests/user_detail.dart';
import 'package:user/user.dart';

import '../gql.mocks.dart';
import 'no_op_requests_mock.dart';

void main() {
  const String fakeId = 'fake-id';
  const String fakeName = 'fake-name';
  const String fakeEmail = 'fake-email';
  const String fakeImage = 'fake-image';
  const String fakeAbout = 'fake-about';

  final GQLClient fakeClient = MockGQLClient();

  final UserDetailRequest detailRequest = UserDetailRequest(fakeClient);

  final UserRepository fakeRepository = UserRepository(
    createRequest: const NoOpUserCreateReq(),
    updateRequest: const NoOpUserUpdateReq(),
    detailRequest: detailRequest,
  );

  group('Verify behavior of [UserUpdateRequest]:', () {
    setUpAll(() {
      final QueryOptions fakeDetailOptions = MockQueryOptions();

      const String fakeJsonResult = '''
        {
          "userDetail": {
            "id": "$fakeId",
            "name": "$fakeName",
            "email": "$fakeEmail",
            "image": "$fakeImage",
            "about": "$fakeAbout"
          }
        }
      ''';

      when(fakeClient.query(fakeDetailOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });

    test(
      'When [execute] is called with no variables, '
      'then return a [User] with id, name, email, image, and about',
      () async {
        final User result = await fakeRepository.detail();

        expect(result.id, equals(fakeId));
        expect(result.name, equals(fakeName));
        expect(result.email, equals(fakeEmail));
        expect(result.image, equals(fakeImage));
        expect(result.about, equals(fakeAbout));
      },
    );
  });
}
