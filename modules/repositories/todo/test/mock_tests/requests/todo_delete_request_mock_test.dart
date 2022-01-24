import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:todo/src/requests/todo_delete.dart';
import 'package:todo/todo.dart';

import '../gql.mocks.dart';
import '../no_op_requests_mock.dart';

void main() {
  const String fakeId = 'fake-id';
  const TodoDeleteInput fakeInput = TodoDeleteInput(id: fakeId);

  final GQLClient fakeClient = MockGQLClient();

  final TodoDeleteRequest deleteRequest = TodoDeleteRequest(fakeClient);

  final TodoRepository fakeTodoRepository = TodoRepository(
    createRequest: const NoOpCreateReq(),
    updateRequest: const NoOpUpdateReq(),
    deleteRequest: deleteRequest,
    listRequest: const NoOpGetListReq(),
    detailRequest: const NoOpGetDetailReq(),
  );

  group('Verify behavior of [TodoDeleteRequest]:', () {
    setUpAll(() {
      final MutationOptions deleteRequestOptions = MockMutationOptions(
        variables: fakeInput.variables,
      );

      const String fakeJsonResult = '''
        {
          "todoDelete": {
            "success": true
          }
        }
      ''';

      when(fakeClient.mutate(deleteRequestOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });
    test(
      'When [execute] is called with id, '
      'then return `true`',
      () async {
        final bool success = await fakeTodoRepository.delete(fakeInput);

        expect(success, isTrue);
      },
    );
  });
}
