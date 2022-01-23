class TodoListInput {
  const TodoListInput({
    required this.page,
    this.limit = 10,
  });

  final int page;
  final int limit;

  Map<String, dynamic> get variables {
    return <String, dynamic>{
      'page': page,
      'limit': limit,
    };
  }
}
