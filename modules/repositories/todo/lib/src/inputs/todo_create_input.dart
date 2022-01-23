import '../entities/todo.dart';
import '../entities/todo_status.dart';

class TodoCreateInput {
  const TodoCreateInput(this.todo);

  final Todo todo;

  Map<String, dynamic> get variables {
    return <String, dynamic>{
      'title': todo.title,
      'subtitle': todo.subtitle,
      'description': todo.description,
      'status': todo.status.name.toUpperCase(),
    };
  }
}
