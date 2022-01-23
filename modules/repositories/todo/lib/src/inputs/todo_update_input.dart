import '../entities/todo.dart';
import 'todo_create_input.dart';

class TodoUpdateInput extends TodoCreateInput {
  const TodoUpdateInput(Todo todo) : super(todo);

  @override
  Map<String, dynamic> get variables {
    return <String, dynamic>{
      'id': todo.id,
      ...super.variables,
    };
  }
}
