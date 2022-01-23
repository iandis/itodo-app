enum TodoStatus {
  todo,
  inProgress,
  done,
}

extension TodoStatusName on TodoStatus {
  String get name {
    switch (index) {
      case 0:
        return 'todo';
      case 1:
        return 'in_progress';
      case 2:
        return 'done';
      default:
        throw IndexError(
          index,
          TodoStatus.values.length,
        );
    }
  }
}
