part of 'todo_repository.dart';

class _TodoRepositoryImpl implements TodoRepository {
  const _TodoRepositoryImpl({
    required TodoCreateRequest createRequest,
    required TodoUpdateRequest updateRequest,
    required TodoDeleteRequest deleteRequest,
    required TodoGetDetailRequest detailRequest,
    required TodoGetListRequest listRequest,
  })  : _createRequest = createRequest,
        _updateRequest = updateRequest,
        _deleteRequest = deleteRequest,
        _detailRequest = detailRequest,
        _listRequest = listRequest;

  factory _TodoRepositoryImpl.create(GQLClient client) {
    return _TodoRepositoryImpl(
      createRequest: TodoCreateRequest(client),
      updateRequest: TodoUpdateRequest(client),
      deleteRequest: TodoDeleteRequest(client),
      detailRequest: TodoGetDetailRequest(client),
      listRequest: TodoGetListRequest(client),
    );
  }

  final TodoCreateRequest _createRequest;
  final TodoUpdateRequest _updateRequest;
  final TodoDeleteRequest _deleteRequest;
  final TodoGetDetailRequest _detailRequest;
  final TodoGetListRequest _listRequest;

  @override
  Future<Todo> create(TodoCreateInput input) {
    return _createRequest.execute(input.variables);
  }

  @override
  Future<Todo> update(TodoUpdateInput input) {
    return _updateRequest.execute(input.variables);
  }

  @override
  Future<bool> delete(TodoDeleteInput input) {
    return _deleteRequest.execute(input.variables);
  }

  @override
  Future<Todo> detail(TodoDetailInput input) {
    return _detailRequest.execute(input.variables);
  }

  @override
  Future<List<Todo>> list(TodoListInput input) {
    return _listRequest.execute(input.variables);
  }
}
