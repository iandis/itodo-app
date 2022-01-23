import 'package:network/network.dart';

import '../entities/todo.dart';

class TodoUpdateRequest extends GQLExecutor<Todo> {
  const TodoUpdateRequest(GQLClient client)
      : super(
          client: client,
          parser: const _TodoUpdateParser(),
        );
}

class _TodoUpdateParser extends GQLParser<Todo> {
  const _TodoUpdateParser();

  @override
  String get document => r'''
    mutation todoUpdate(
      $id: String!, 
      $title: String!, 
      $subtitle: String,
      $description: String,
      $status: TodoStatus!, 
    ) {
      todoUpdate(todoUpdateInput: {
        id: $id,
        title: $title,
        subtitle: $subtitle,
        description: $description,
        status: $status
      }) {
        id
        status
        updatedAt
      }
    }
  ''';

  @override
  GQLType get type => GQLType.mutation;

  @override
  Todo parse(Map<String, dynamic> json) {
    final dynamic todo = json['todoUpdate'];
    return Todo.fromMap(todo as Map<String, dynamic>);
  }
}
