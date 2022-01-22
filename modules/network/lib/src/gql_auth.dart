import 'dart:async';

abstract class GQLAuth {
  FutureOr<String?> getToken();
}
