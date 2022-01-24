import 'dart:convert';

import 'package:graphql/client.dart';
import 'package:mockito/mockito.dart';
import 'package:network/network.dart';
import 'package:test/test.dart';
import 'package:todo/src/requests/todo_get_list.dart';
import 'package:todo/todo.dart';

import '../gql.mocks.dart';
import '../no_op_requests_mock.dart';

void main() {
  const int fakePage = 0;
  const int fakeLimit = 3;
  const TodoListInput fakeInput = TodoListInput(
    page: fakePage,
    limit: fakeLimit,
  );

  final GQLClient fakeClient = MockGQLClient();

  final TodoGetListRequest listRequest = TodoGetListRequest(fakeClient);

  final TodoRepository fakeTodoRepository = TodoRepository(
    createRequest: const NoOpCreateReq(),
    updateRequest: const NoOpUpdateReq(),
    deleteRequest: const NoOpDeleteReq(),
    listRequest: listRequest,
    detailRequest: const NoOpGetDetailReq(),
  );

  group('Verify behavior of [TodoGetListRequest]:', () {
    setUpAll(() {
      final QueryOptions listRequestOptions = MockQueryOptions(
        variables: fakeInput.variables,
      );

      const String fakeJsonResult = '''
        {
          "todoList": {
            "todos": [
              {
                "id": "baa2a35d-55e5-4b24-93ca-26db08e10f22",
                "title": "Test todo tes 1",
                "subtitle": null,
                "description": null,
                "status": "TODO",
                "createdAt": "2022-01-23T03:52:21.277Z",
                "updatedAt": "2022-01-23T03:52:21.277Z"
              },
              {
                "id": "b82c6917-983b-48a4-aed3-5d612a829f9c",
                "title": "Test update todo !",
                "subtitle": "This is subtitle.",
                "description": null,
                "status": "DONE",
                "createdAt": "2022-01-23T02:59:53.832Z",
                "updatedAt": "2022-01-23T03:26:54.379Z"
              },
              {
                "id": "4f201c06-ad71-4d16-bba2-a00f8f59dd28",
                "title": "Test todo 2",
                "subtitle": null,
                "description": null,
                "status": "IN_PROGRESS",
                "createdAt": "2022-01-21T15:29:26.722Z",
                "updatedAt": "2022-01-21T15:29:26.722Z"
              }
            ]
          }
        }
      ''';

      when(fakeClient.query(listRequestOptions)).thenAnswer((_) async {
        return QueryResult(
          data: json.decode(fakeJsonResult) as Map<String, dynamic>,
          source: null,
        );
      });
    });
    test(
      'When [execute] is called with [page] = $fakePage and [limit] = $fakeLimit, '
      'then return a list of [Todo] with [length] = 3',
      () async {
        final List<Todo> todos = await fakeTodoRepository.list(fakeInput);

        expect(todos.length, equals(3));
        expect(todos.any((t) => t.status == TodoStatus.todo), isTrue);
        expect(todos.any((t) => t.status == TodoStatus.inProgress), isTrue);
        expect(todos.any((t) => t.status == TodoStatus.done), isTrue);
      },
    );
  });
}
