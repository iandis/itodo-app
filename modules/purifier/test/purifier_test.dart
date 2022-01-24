import 'dart:convert';

import 'package:purifier/purifier.dart';
import 'package:test/test.dart';

bool _normalFunc() {
  return true;
}

Future<bool> _normalAsyncFunc() async {
  return _normalFunc();
}

Map<String, dynamic> _funcThrowingFormatException() {
  const String invalidJson = '<body></body>';
  return json.decode(invalidJson) as Map<String, dynamic>;
}

Future<Map<String, dynamic>> _asyncFuncThrowingFormatException() async {
  return _funcThrowingFormatException();
}

int _funcThrowingAssertionError() {
  assert(false);
  return 0;
}

Future<int> _asyncFuncThrowingAssertionError() async {
  return _funcThrowingAssertionError();
}

double _funcThrowingTypeError() {
  double? nullable;
  return nullable!;
}

Future<double> _asyncFuncThrowingTypeError() async {
  return _funcThrowingTypeError();
}

void main() {
  Purifier()
    ..on<FormatException>((FormatException error) {
      return 'Handled format exception';
    })
    ..on<AssertionError>((AssertionError error) {
      return 'Handled assertion error';
    })
    ..on<TypeError>((TypeError error) {
      return 'Handled type error';
    });

  group('Verify behavior of [Purifier]:', () {
    test(
      'When a function runs normally, '
      'then return the value',
      () async {
        final Purified<bool> normal = Purifier().run(_normalFunc);
        final Purified<bool> async = await Purifier().async(_normalAsyncFunc);

        expect(normal.hasError && async.hasError, isFalse);
        expect(normal.hasValue && async.hasValue, isTrue);
        expect(normal.value && async.value, isTrue);
        expect(() => normal.error, throwsException);
        expect(() => async.error, throwsException);
      },
    );

    test(
      'When a function throws [FormatException], '
      'then return an error message of "Handled format exception"',
      () async {
        final Purified<Map<String, dynamic>> normal = Purifier().run(
          _funcThrowingFormatException,
        );
        final Purified<Map<String, dynamic>> async = await Purifier().async(
          _asyncFuncThrowingFormatException,
        );

        expect(normal.hasError && async.hasError, isTrue);
        expect(normal.hasValue && async.hasValue, isFalse);
        expect(normal.error, 'Handled format exception');
        expect(async.error, 'Handled format exception');
        expect(() => normal.value, throwsException);
        expect(() => async.value, throwsException);
      },
    );

    test(
      'When a function throws [AssertionError], '
      'then return an error message of "Handled assertion error"',
      () async {
        final Purified<int> normal = Purifier().run(
          _funcThrowingAssertionError,
        );
        final Purified<int> async = await Purifier().async(
          _asyncFuncThrowingAssertionError,
        );

        expect(normal.hasError && async.hasError, isTrue);
        expect(normal.hasValue && async.hasValue, isFalse);
        expect(normal.error, 'Handled assertion error');
        expect(async.error, 'Handled assertion error');
        expect(() => normal.value, throwsException);
        expect(() => async.value, throwsException);
      },
    );

    test(
      'When a function throws [TypeError], '
      'then return an error message of "Handled type error"',
      () async {
        final Purified<double> normal = Purifier().run(
          _funcThrowingTypeError,
        );
        final Purified<double> async = await Purifier().async(
          _asyncFuncThrowingTypeError,
        );

        expect(normal.hasError && async.hasError, isTrue);
        expect(normal.hasValue && async.hasValue, isFalse);
        expect(normal.error, 'Handled type error');
        expect(async.error, 'Handled type error');
        expect(() => normal.value, throwsException);
        expect(() => async.value, throwsException);
      },
    );
  });
}
