import 'package:network/network.dart';

import '../entities/todo.dart';

class TodoCreateRequest extends GQLExecutor<Todo> {
  const TodoCreateRequest(GQLClient client)
      : super(
          client: client,
          parser: const _TodoCreateParser(),
        );
}

class _TodoCreateParser extends GQLParser<Todo> {
  const _TodoCreateParser();

  @override
  String get document => r'''
    mutation todoCreate(
      $title: String!,
      $subtitle: String,
      $description: String,
      $status: TodoStatus!
    ) {
      todoCreate(todoCreateInput: {
        title: $title,
        subtitle: $subtitle,
        description: $description,
        status: $status
      }) {
        id
        createdAt
        updatedAt
      }
    }
  ''';

  @override
  GQLType get type => GQLType.mutation;

  @override
  Todo parse(Map<String, dynamic> json) {
    final dynamic todo = json['todoCreate'];
    return Todo.fromMap(todo as Map<String, dynamic>);
  }
}
