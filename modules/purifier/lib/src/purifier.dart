import 'dart:developer' as dev show log;

import 'purified.dart';

class Purifier {
  factory Purifier() => _instance;

  const Purifier._();

  static const Purifier _instance = Purifier._();

  static final List<_ErrHandler<Object>> _errHandlers = <_ErrHandler<Object>>[];

  static String Function(Object error)? _unknownErrHandler;

  Purifier on<T extends Object>(String Function(T error) handler) {
    final _ErrHandler<T> errHandler = _ErrHandler<T>(handler);
    _errHandlers.add(errHandler);
    return this;
  }

  Purifier orElse(String Function(Object error) handler) {
    _unknownErrHandler = handler;
    return this;
  }

  String? _handle(Object error) {
    final int errHandlerIndex = _errHandlers.indexWhere(
      (final _ErrHandler<Object> handler) => handler.isTypeOf(error),
    );

    if (errHandlerIndex != -1) {
      final _ErrHandler<Object> handler = _errHandlers[errHandlerIndex];
      return handler(error);
    }

    return _unknownErrHandler?.call(error);
  }

  Purified<T> run<T>(T Function() f) {
    try {
      final T result = f();
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

  Future<Purified<T>> async<T>(Future<T> Function() f) async {
    try {
      final T result = await f();
      return Purified<T>.success(result);
    } catch (err, stack) {
      dev.log(
        'An async operation returning [$T] throws an error.',
        name: 'Purifier',
        error: err,
        stackTrace: stack,
      );
      final String? errMessage = _handle(err);
      return Purified<T>.failed(errMessage ?? err.toString());
    }
  }
}

class _ErrHandler<T extends Object> {
  const _ErrHandler(this._handler);

  final String Function(T error) _handler;

  bool isTypeOf<E>(E other) => other is T;

  String call(T error) {
    return _handler(error);
  }
}
