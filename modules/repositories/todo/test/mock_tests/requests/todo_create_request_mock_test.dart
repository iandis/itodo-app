import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:todo/src/requests/todo_create.dart';
import 'package:todo/todo.dart';

import '../gql.mocks.dart';
import '../no_op_requests_mock.dart';

void main() {
  const String fakeId = 'fake-id';
  const String fakeTitle = 'fake-title';
  const TodoCreateInput fakeInput = TodoCreateInput(
    Todo(title: fakeTitle),
  );

  final GQLClient fakeClient = MockGQLClient();

  final TodoCreateRequest createRequest = TodoCreateRequest(fakeClient);

  final TodoRepository fakeTodoRepository = TodoRepository(
    createRequest: createRequest,
    updateRequest: const NoOpUpdateReq(),
    deleteRequest: const NoOpDeleteReq(),
    listRequest: const NoOpGetListReq(),
    detailRequest: const NoOpGetDetailReq(),
  );

  group('Verify behavior of [TodoCreateRequest]:', () {
    setUpAll(() {
      final MutationOptions createRequestOptions = MockMutationOptions(
        variables: fakeInput.variables,
      );

      const String fakeJsonResult = '''
        {
          "todoCreate": {
            "id": "$fakeId",
            "title": "$fakeTitle",
            "status": "TODO",
            "createdAt": "2022-01-23T03:52:21.277Z",
            "updatedAt": "2022-01-23T03:52:21.277Z"
          }
        }
      ''';

      when(fakeClient.mutate(createRequestOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });
    test(
      'When [execute] is called with title, '
      'then return a [Todo] with id, title, and status of "TODO"',
      () async {
        final Todo todo = await fakeTodoRepository.create(fakeInput);

        expect(todo.id, equals(fakeId));
        expect(todo.title, equals(fakeTitle));
        expect(todo.status, equals(TodoStatus.todo));
      },
    );
  });
}
