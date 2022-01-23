import 'package:network/network.dart';

import 'entities/todo.dart';

import 'inputs/todo_create_input.dart';
import 'inputs/todo_delete_input.dart';
import 'inputs/todo_detail_input.dart';
import 'inputs/todo_list_input.dart';
import 'inputs/todo_update_input.dart';

import 'requests/todo_create.dart';
import 'requests/todo_delete.dart';
import 'requests/todo_get_detail.dart';
import 'requests/todo_get_list.dart';
import 'requests/todo_update.dart';

part 'todo_repository_impl.dart';

abstract class TodoRepository {
  const factory TodoRepository({
    required TodoCreateRequest createRequest,
    required TodoUpdateRequest updateRequest,
    required TodoDeleteRequest deleteRequest,
    required TodoGetDetailRequest detailRequest,
    required TodoGetListRequest listRequest,
  }) = _TodoRepositoryImpl;

  factory TodoRepository.create(GQLClient client) = _TodoRepositoryImpl.create;

  Future<Todo> create(TodoCreateInput input);
  Future<Todo> update(TodoUpdateInput input);
  Future<bool> delete(TodoDeleteInput input);
  Future<Todo> detail(TodoDetailInput input);
  Future<List<Todo>> list(TodoListInput input);
}
