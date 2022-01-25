import 'package:auth/auth.dart';
import 'package:auth/src/providers/google_auth_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_repository_test.mocks.dart';

@GenerateMocks([
  GoogleAuthService,
])
void main() {
  const String fakeId = 'fake-id';
  const String fakeEmail = 'fake@email.com';
  const String fakePassword = 'fake-pass';

  final GoogleAuthService fakeAuthService = MockGoogleAuthService();
  final AuthRepository fakeRepository = AuthRepository(
    googleAuthService: fakeAuthService,
  );

  group('Verify behavior of [AuthRepository]:', () {
    const int maxSignInSteps = 2;
    int signInStep = 0;

    setUp(() {
      signInStep++;
    });

    tearDownAll(() {
      verify(fakeAuthService.signIn())
          .called(maxSignInSteps);
    });

    setUpAll(() {
      when(fakeAuthService.signIn()).thenAnswer((_) async {
        if (signInStep == 1) {
          return const AuthResult(
            id: fakeId,
            isNewUser: true,
          );
        }
      });

      when(
        fakeAuthService.signUp(
          email: fakeEmail,
          password: fakePassword,
        ),
      ).thenAnswer((_) async {
        return const AuthResult(
          id: fakeId,
          isNewUser: true,
          email: fakeEmail,
        );
      });

      when(fakeAuthService.signOut()).thenAnswer((_) => Future<void>.value());
    });

    test(
      'When [signIn] with `google` is called and user accepts, '
      'then return an [AuthResult] with an `id` and `isNewUser` = true',
      () async {
        final AuthResult? authResult = await fakeRepository.signIn();

        expect(authResult, isNotNull);
        expect(authResult!.id, equals(fakeId));
        expect(authResult.isNewUser, isTrue);
      },
    );

    test(
      'When [signIn] with `google` is called and user cancels, '
      'then return null',
      () async {
        final AuthResult? authResult = await fakeRepository.signIn();

        expect(authResult, isNull);
      },
    );

    test(
      'When [signUp] with `google` is called with email and password, '
      'then return an [AuthResult] with an `id`, `isNewUser` = true, and `email`',
      () async {
        final AuthResult authResult = await fakeRepository.signUp(
          email: fakeEmail,
          password: fakePassword,
        );

        expect(authResult.id, equals(fakeId));
        expect(authResult.isNewUser, isTrue);
        expect(authResult.email, equals(fakeEmail));
      },
    );

    test(
      'When [signOut] with `google` is called, '
      'then completes without error',
      ()  {
        expect(
          fakeRepository.signOut(),
          completes,
        );
      },
    );
  });
}
