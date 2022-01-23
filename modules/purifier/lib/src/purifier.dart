import 'dart:async' show FutureOr;
import 'dart:developer' as dev show log;

import 'purified.dart';

// ignore: avoid_classes_with_only_static_members
class Purifier {
  static final Map<Type, Function> _errHandlers = <Type, Function>{};

  static void on<T>(String Function(T error) handler) {
    assert(
      !_errHandlers.containsKey(T),
      'You can only register one error handler for each type',
    );

    _errHandlers[T] = handler;
  }

  static String? _handle(Object error) {
    return _errHandlers[error.runtimeType]?.call(error) as String?;
  }

  static FutureOr<Purified<T>> run<T>(FutureOr<T> Function() f) async {
    try {
      final T result = await f();
      return Purified<T>.success(result);
    } catch (err, stack) {
      dev.log(
        'An operation returning [$T] throws an error.',
        name: 'Purifier',
        error: err,
        stackTrace: stack,
      );
      final String? errMessage = _handle(err);
      return Purified<T>.failed(errMessage ?? err.toString());
    }
  }
}
