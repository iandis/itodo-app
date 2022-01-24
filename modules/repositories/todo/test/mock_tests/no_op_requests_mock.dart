import 'package:todo/src/requests/todo_create.dart';
import 'package:todo/src/requests/todo_delete.dart';
import 'package:todo/src/requests/todo_get_detail.dart';
import 'package:todo/src/requests/todo_get_list.dart';
import 'package:todo/src/requests/todo_update.dart';

class NoOpCreateReq implements TodoCreateRequest {
  const NoOpCreateReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}

class NoOpUpdateReq implements TodoUpdateRequest {
  const NoOpUpdateReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}

class NoOpDeleteReq implements TodoDeleteRequest {
  const NoOpDeleteReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}

class NoOpGetListReq implements TodoGetListRequest {
  const NoOpGetListReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}

class NoOpGetDetailReq implements TodoGetDetailRequest {
  const NoOpGetDetailReq();

  @override
  dynamic noSuchMethod(Invocation invocation) {}
}
