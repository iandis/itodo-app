import 'package:network/network.dart';

import '../entities/todo.dart';

class TodoGetListRequest extends GQLExecutor<List<Todo>> {
  const TodoGetListRequest(GQLClient client)
      : super(
          client: client,
          parser: const _TodoGetListParser(),
        );
}

class _TodoGetListParser extends GQLParser<List<Todo>> {
  const _TodoGetListParser();

  @override
  String get document => r'''
    query todoList($page: Int!, $limit: Int!) {
      todoList(todoListInput: {
        page: $page,
        limit: $limit
      }) {
        todos {
          id
          title
          subtitle
          status
          createdAt
          updatedAt
        }
      }
    }
  ''';

  @override
  GQLType get type => GQLType.query;

  @override
  List<Todo> parse(Map<String, dynamic> json) {
    final List<dynamic> todos = json['todoList']['todos'] as List<dynamic>;

    return todos
        .map((dynamic todo) => Todo.fromMap(todo as Map<String, dynamic>))
        .toList(growable: false);
  }
}
