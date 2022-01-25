// Mocks generated by Mockito 5.0.17 from annotations
// in auth/test/mock_tests/auth_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:auth/src/entities/auth_result.dart' as _i2;
import 'package:auth/src/providers/google_auth_service.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeAuthResult_0 extends _i1.Fake implements _i2.AuthResult {}

/// A class which mocks [GoogleAuthService].
///
/// See the documentation for Mockito's code generation for more information.
class MockGoogleAuthService extends _i1.Mock implements _i3.GoogleAuthService {
  MockGoogleAuthService() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.AuthResult?> signIn() =>
      (super.noSuchMethod(Invocation.method(#signIn, []),
              returnValue: Future<_i2.AuthResult?>.value())
          as _i4.Future<_i2.AuthResult?>);
  @override
  _i4.Future<_i2.AuthResult> signUp({String? email, String? password}) => (super
      .noSuchMethod(
          Invocation.method(#signUp, [], {#email: email, #password: password}),
          returnValue: Future<_i2.AuthResult>.value(_FakeAuthResult_0())) as _i4
      .Future<_i2.AuthResult>);
  @override
  _i4.Future<void> signOut() =>
      (super.noSuchMethod(Invocation.method(#signOut, []),
          returnValue: Future<void>.value(),
          returnValueForMissingStub: Future<void>.value()) as _i4.Future<void>);
}
