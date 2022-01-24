import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:todo/src/requests/todo_update.dart';
import 'package:todo/todo.dart';

import '../gql.mocks.dart';
import '../no_op_requests_mock.dart';

void main() {
  const String fakeId = 'fake-id';
  const String fakeTitle = 'fake-title';
  const TodoUpdateInput fakeInput = TodoUpdateInput(
    Todo(
      id: fakeId,
      title: fakeTitle,
      status: TodoStatus.done,
    ),
  );

  final GQLClient fakeClient = MockGQLClient();

  final TodoUpdateRequest updateRequest = TodoUpdateRequest(fakeClient);

  final TodoRepository fakeTodoRepository = TodoRepository(
    createRequest: const NoOpCreateReq(),
    updateRequest: updateRequest,
    deleteRequest: const NoOpDeleteReq(),
    listRequest: const NoOpGetListReq(),
    detailRequest: const NoOpGetDetailReq(),
  );

  group('Verify behavior of [TodoUpdateRequest]:', () {
    setUpAll(() {
      final MutationOptions updateRequestOptions = MockMutationOptions(
        variables: fakeInput.variables,
      );

      const String fakeJsonResult = '''
        {
          "todoUpdate": {
            "id": "$fakeId",
            "title": "$fakeTitle",
            "status": "DONE",
            "createdAt": "2022-01-23T03:52:21.277Z",
            "updatedAt": "2022-01-23T03:52:21.277Z"
          }
        }
      ''';

      when(fakeClient.mutate(updateRequestOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });
    test(
      'When [execute] is called with id, title and status of "DONE", '
      'then return a [Todo] with id, title, and status of "DONE"',
      () async {
        final Todo todo = await fakeTodoRepository.update(fakeInput);

        expect(todo.id, equals(fakeId));
        expect(todo.title, equals(fakeTitle));
        expect(todo.status, equals(TodoStatus.done));
      },
    );
  });
}
