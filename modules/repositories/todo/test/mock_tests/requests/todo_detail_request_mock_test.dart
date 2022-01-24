import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:todo/src/requests/todo_get_detail.dart';
import 'package:todo/todo.dart';

import '../gql.mocks.dart';
import '../no_op_requests_mock.dart';

void main() {
  const String fakeId = 'fake-id';
  const String fakeTitle = 'fake-title';
  const TodoDetailInput fakeInput = TodoDetailInput(id: fakeId);

  final GQLClient fakeClient = MockGQLClient();

  final TodoGetDetailRequest detailRequest = TodoGetDetailRequest(fakeClient);

  final TodoRepository fakeTodoRepository = TodoRepository(
    createRequest: const NoOpCreateReq(),
    updateRequest: const NoOpUpdateReq(),
    deleteRequest: const NoOpDeleteReq(),
    listRequest: const NoOpGetListReq(),
    detailRequest: detailRequest,
  );

  group('Verify behavior of [TodoGetDetailRequest]:', () {
    setUpAll(() {
      final QueryOptions detailRequestOptions = MockQueryOptions(
        variables: fakeInput.variables,
      );

      const String fakeJsonResult = '''
        {
          "todoDetail": {
            "id": "$fakeId",
            "title": "$fakeTitle",
            "subtitle": null,
            "description": null,
            "status": "TODO",
            "createdAt": "2022-01-23T03:52:21.277Z",
            "updatedAt": "2022-01-23T03:52:21.277Z"
          }
        }
      ''';

      when(fakeClient.query(detailRequestOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });
    test(
      'When [execute] is called with id, '
      'then return a [Todo] with id, title, and status of "TODO"',
      () async {
        final Todo todo = await fakeTodoRepository.detail(fakeInput);

        expect(todo.id, equals(fakeId));
        expect(todo.title, equals(fakeTitle));
        expect(todo.status, equals(TodoStatus.todo));
      },
    );
  });
}
