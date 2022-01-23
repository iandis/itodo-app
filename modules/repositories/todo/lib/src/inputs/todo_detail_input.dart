class TodoDetailInput {
  const TodoDetailInput({
    required this.id,
  });

  final String id;

  Map<String, dynamic> get variables {
    return <String, dynamic>{
      'id': id,
    };
  }
}
