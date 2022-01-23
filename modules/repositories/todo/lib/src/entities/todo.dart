import 'todo_status.dart';

class Todo {
  const Todo({
    this.id,
    this.title,
    this.subtitle,
    this.description,
    this.status = TodoStatus.todo,
    this.createdAt,
    this.updatedAt,
  });

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'] as String?,
      title: map['title'] as String?,
      subtitle: map['subtitle'] as String?,
      description: map['description'] as String?,
      status: TodoStatus.values.firstWhere(
        (TodoStatus status) {
          final String statusString = map['status'] as String;
          return statusString == status.name.toUpperCase();
        },
        orElse: () => TodoStatus.todo,
      ),
      createdAt: DateTime.tryParse(map['createdAt'] as String? ?? ''),
      updatedAt: DateTime.tryParse(map['updatedAt'] as String? ?? ''),
    );
  }

  final String? id;

  final String? title;

  final String? subtitle;

  final String? description;

  final TodoStatus status;

  final DateTime? createdAt;

  final DateTime? updatedAt;

  Todo copyWith({
    String? id,
    String? title,
    String? subtitle,
    String? description,
    TodoStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      description: description ?? this.description,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Todo copyFrom(covariant Todo other) {
    return copyWith(
      id: other.id,
      title: other.title,
      subtitle: other.subtitle,
      description: other.description,
      status: other.status,
      createdAt: other.createdAt,
      updatedAt: other.updatedAt,
    );
  }
}
