import 'package:network/network.dart';
import '../entities/todo.dart';

class TodoGetDetailRequest extends GQLExecutor<Todo> {
  const TodoGetDetailRequest(GQLClient client)
      : super(
          client: client,
          parser: const _TodoGetDetailParser(),
        );
}

class _TodoGetDetailParser extends GQLParser<Todo> {
  const _TodoGetDetailParser();

  @override
  String get document => r'''
    query todoDetail($id: String!) {
      todoDetail(todoDetailInput: { 
        id: $id
      }) {
        id
        title
        subtitle
        description
        status
        createdAt
        updatedAt
      }
    }
  ''';

  @override
  GQLType get type => GQLType.query;

  @override
  Todo parse(Map<String, dynamic> json) {
    final dynamic todo = json['todoDetail'];
    return Todo.fromMap(todo as Map<String, dynamic>);
  }
}
