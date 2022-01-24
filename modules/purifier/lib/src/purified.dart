import 'package:meta/meta.dart';

abstract class _PurifiedBase<T, E> {
  /// The value of previous succeesful operation.
  ///
  /// Throws an exception if accessed when previous operation failed.
  T get value;

  /// Returns whether the previous operation was successful.
  ///
  /// Best to check this first before accessing [value].
  bool get hasValue;

  /// The error message of previous failed operation.
  ///
  /// Throws an exception if accessed when previous operation succeeded.
  E get error;

  /// Returns whether the previous operation failed.
  ///
  /// Best to check this first before accessing [error].
  bool get hasError;
}

abstract class Purified<T> extends _PurifiedBase<T, String> {
  /// Creates an instance of [Purified] with a value.
  ///
  /// [hasValue] will be true.
  const factory Purified.success(T value) = _Success<T>;

  /// Creates an instance of [Purified] with an error message.
  ///
  /// [hasError] will be true.
  const factory Purified.failed(String error) = _Failed<T>;
}

@sealed
@immutable
abstract class Success<T> extends Purified<T> {
  const factory Success(T value) = _Success<T>;
}

@immutable
class _Success<T> implements Success<T> {
  const _Success(this._value);

  final T _value;

  @override
  T get value => _value;

  @override
  bool get hasValue => true;

  @override
  String get error {
    throw Exception(
      'Error message is not available because previous operation succeeded.',
    );
  }

  @override
  bool get hasError => false;
}

@sealed
@immutable
abstract class Failed<T> extends Purified<T> {
  const factory Failed(String error) = _Failed<T>;
}

@immutable
class _Failed<T> implements Failed<T> {
  const _Failed(this._error);

  final String _error;

  @override
  String get error => _error;

  @override
  bool get hasError => true;

  @override
  T get value {
    throw Exception(
      'Value is not available because previous operation failed.',
    );
  }

  @override
  bool get hasValue => false;
}
