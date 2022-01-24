import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:todo/src/requests/todo_create.dart';
import 'package:todo/src/requests/todo_delete.dart';
import 'package:todo/src/requests/todo_get_detail.dart';
import 'package:todo/src/requests/todo_get_list.dart';
import 'package:todo/src/requests/todo_update.dart';

import 'package:todo/todo.dart';

import 'todo_repository_mock_test.mocks.dart';

@GenerateMocks([
  TodoCreateRequest,
  TodoDeleteRequest,
  TodoGetDetailRequest,
  TodoGetListRequest,
  TodoUpdateRequest,
])
void main() {
  const String fakeId = 'fake-id';
  const String fakeTitle = 'test';
  const Todo fakeTodo = Todo(title: fakeTitle);
  const Todo fakeTodoWithId = Todo(
    id: fakeId,
    title: fakeTitle,
  );

  const TodoCreateInput fakeCreateReqInput = TodoCreateInput(fakeTodo);
  const TodoUpdateInput fakeUpdateReqInput = TodoUpdateInput(fakeTodoWithId);
  const TodoDeleteInput fakeTodoDeleteInput = TodoDeleteInput(id: fakeId);
  const TodoListInput fakeTodoGetListInput = TodoListInput(page: 0);
  const TodoDetailInput fakeTodoGetDetailInput = TodoDetailInput(id: fakeId);

  final TodoCreateRequest createRequest = MockTodoCreateRequest();
  final TodoUpdateRequest updateRequest = MockTodoUpdateRequest();
  final TodoDeleteRequest deleteRequest = MockTodoDeleteRequest();
  final TodoGetListRequest listRequest = MockTodoGetListRequest();
  final TodoGetDetailRequest detailRequest = MockTodoGetDetailRequest();

  final TodoRepository todoRepository = TodoRepository(
    createRequest: createRequest,
    updateRequest: updateRequest,
    deleteRequest: deleteRequest,
    listRequest: listRequest,
    detailRequest: detailRequest,
  );

  group('Verify behavior of [TodoRepository]:', () {
    setUpAll(() {
      when(createRequest.execute(fakeCreateReqInput.variables))
          .thenAnswer((_) async => fakeTodoWithId);

      when(updateRequest.execute(fakeUpdateReqInput.variables))
          .thenAnswer((_) async => fakeTodoWithId);

      when(deleteRequest.execute(fakeTodoDeleteInput.variables))
          .thenAnswer((_) async => true);

      when(listRequest.execute(fakeTodoGetListInput.variables)).thenAnswer(
        (_) async => List<Todo>.filled(
          fakeTodoGetListInput.limit,
          fakeTodo,
        ),
      );

      when(detailRequest.execute(fakeTodoGetDetailInput.variables))
          .thenAnswer((_) async => fakeTodoWithId);
    });

    test(
      'When create a todo with title, '
      'then return a [Todo] with id',
      () async {
        final Todo todo = await todoRepository.create(fakeCreateReqInput);

        expect(todo.id, isNotNull);
        expect(todo.id, equals(fakeId));
        expect(todo.title, equals(fakeCreateReqInput.todo.title));
      },
    );

    test(
      'When create a todo without title, '
      'then throw a [TypeError]',
      () {
        expect(
          () => todoRepository.create(const TodoCreateInput(Todo())),
          throwsA(isA<TypeError>()),
        );
      },
    );

    test(
      'When update a todo with id and title, '
      'then return a [Todo] with id and title',
      () async {
        final Todo todo = await todoRepository.update(fakeUpdateReqInput);

        expect(todo.id, isNotNull);
        expect(todo.id, equals(fakeUpdateReqInput.todo.id));

        expect(todo.title, isNotNull);
        expect(todo.title, equals(fakeUpdateReqInput.todo.title));
      },
    );

    test(
      'When update a todo without id nor title, '
      'then throw a [TypeError]',
      () {
        expect(
          () => todoRepository.update(
            const TodoUpdateInput(Todo()),
          ),
          throwsA(isA<TypeError>()),
        );

        expect(
          () => todoRepository.update(
            const TodoUpdateInput(Todo(id: fakeId)),
          ),
          throwsA(isA<TypeError>()),
        );

        expect(
          () => todoRepository.update(
            const TodoUpdateInput(Todo(title: fakeTitle)),
          ),
          throwsA(isA<TypeError>()),
        );
      },
    );

    test(
      'When delete a todo with id, '
      'then return [true]',
      () async {
        final bool success = await todoRepository.delete(
          const TodoDeleteInput(id: fakeId),
        );

        expect(success, isTrue);
      },
    );

    test(
      'When get list todo with [page] = 0 and [limit] = 10, '
      'then return a list todo with [length] = 10',
      () async {
        final List<Todo> todos = await todoRepository.list(
          const TodoListInput(page: 0),
        );

        expect(todos.length, equals(10));
      },
    );

    test(
      'When get detail todo with id, '
      'then return a todo with id and title',
      () async {
        final Todo todo = await todoRepository.detail(
          const TodoDetailInput(id: fakeId),
        );

        expect(todo.id, isNotNull);
        expect(todo.id, equals(fakeId));

        expect(todo.title, isNotNull);
        expect(todo.title, equals(fakeTitle));
      },
    );
  });
}
