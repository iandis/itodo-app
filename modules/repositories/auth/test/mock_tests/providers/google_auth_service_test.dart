import 'package:auth/auth.dart';
import 'package:auth/src/providers/google_auth_provider.dart';
import 'package:auth/src/providers/google_auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart' hide GoogleAuthProvider;
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'google_auth_service_test.mocks.dart';

const String _fakeIdToken = 'fake-id-token';
const String _fakeUid = 'fake-uid';
const String _fakeEmail = 'fake-email';
const String _fakePassword = 'fake-password';
const String _fakeDisplayName = 'fake-display-name';
const String _fakePhotoUrl = 'fake-photo-url';

class FakeUser implements User {
  const FakeUser();
  @override
  dynamic noSuchMethod(Invocation invocation) {}

  @override
  String get uid => _fakeUid;

  @override
  String get displayName => _fakeDisplayName;

  @override
  String get email => _fakeEmail;

  @override
  String get photoURL => _fakePhotoUrl;

  @override
  Future<String> getIdToken([bool forceRefresh = false]) async {
    return _fakeIdToken;
  }
}

class FakeAdditionalUserInfo implements AdditionalUserInfo {
  const FakeAdditionalUserInfo();

  @override
  dynamic noSuchMethod(Invocation invocation) {}

  @override
  bool get isNewUser => true;
}

@GenerateMocks([
  FirebaseAuth,
  GoogleAuthProvider,
  GoogleSignIn,
  GoogleSignInAccount,
  GoogleSignInAuthentication,
  UserCredential,
])
void main() {
  const String fakeAccessToken = 'fake-access-token';

  final FirebaseAuth fakeFirebaseAuth = MockFirebaseAuth();
  final GoogleSignIn fakeGoogleSignIn = MockGoogleSignIn();
  final GoogleAuthProvider fakeGoogleAuthProvider = MockGoogleAuthProvider();

  final GoogleAuthService fakeGoogleAuthService = GoogleAuthService(
    firebaseAuth: fakeFirebaseAuth,
    googleSignIn: fakeGoogleSignIn,
    googleAuthProvider: fakeGoogleAuthProvider,
  );

  final GoogleSignInAccount fakeGoogleSignInAccount = MockGoogleSignInAccount();
  final GoogleSignInAuthentication fakeGoogleSignInAuthentication =
      MockGoogleSignInAuthentication();

  const AuthCredential fakeAuthCredential = AuthCredential(
    signInMethod: 'google',
    providerId: 'googl',
    token: 0,
  );

  final UserCredential fakeUserCredential = MockUserCredential();

  const User fakeUser = FakeUser();

  group('Verify behavior of [GoogleAuthService]:', () {
    const int maxGoogleSignInSteps = 2;
    int currentGoogleSignInStep = 1;

    tearDown(() {
      currentGoogleSignInStep++;
    });

    tearDownAll(() {
      verify(fakeGoogleSignIn.signIn()).called(maxGoogleSignInSteps);
    });

    setUpAll(() {
      when(fakeGoogleSignIn.signIn()).thenAnswer((_) async {
        if (currentGoogleSignInStep == 2) {
          return fakeGoogleSignInAccount;
        }
      });

      when(fakeGoogleSignInAccount.authentication).thenAnswer((_) async {
        return fakeGoogleSignInAuthentication;
      });

      when(fakeGoogleSignInAuthentication.accessToken)
          .thenReturn(fakeAccessToken);

      when(fakeGoogleSignInAuthentication.idToken).thenReturn(_fakeIdToken);

      when(
        fakeGoogleAuthProvider.create(
          accessToken: fakeAccessToken,
          idToken: _fakeIdToken,
        ),
      ).thenReturn(fakeAuthCredential);

      when(fakeFirebaseAuth.signInWithCredential(fakeAuthCredential))
          .thenAnswer((_) async => fakeUserCredential);

      when(fakeUserCredential.user).thenReturn(fakeUser);

      when(fakeUserCredential.additionalUserInfo)
          .thenReturn(const FakeAdditionalUserInfo());

      when(
        fakeFirebaseAuth.createUserWithEmailAndPassword(
          email: _fakeEmail,
          password: _fakePassword,
        ),
      ).thenAnswer((_) async => fakeUserCredential);

      when(fakeFirebaseAuth.signOut()).thenAnswer((_) => Future<void>.value());
    });

    test(
      'When [signIn] is called and user cancels, '
      'then return null',
      () async {
        final AuthResult? result = await fakeGoogleAuthService.signIn();

        expect(result, isNull);
      },
    );

    test(
      'When [signIn] is called and user signs in, '
      'then return [AuthResult]',
      () async {
        final AuthResult? result = await fakeGoogleAuthService.signIn();

        expect(result, isNotNull);
        expect(result!.id, equals(_fakeUid));
        expect(result.isNewUser, isTrue);
        expect(result.token, equals(_fakeIdToken));
        expect(result.name, equals(_fakeDisplayName));
        expect(result.email, equals(_fakeEmail));
        expect(result.image, equals(_fakePhotoUrl));
      },
    );

    test('When [signUp] is called, then return [AuthResult]', () async {
      final AuthResult result = await fakeGoogleAuthService.signUp(
        email: _fakeEmail,
        password: _fakePassword,
      );

      expect(result.id, equals(_fakeUid));
      expect(result.isNewUser, isTrue);
      expect(result.token, equals(_fakeIdToken));
      expect(result.name, equals(_fakeDisplayName));
      expect(result.email, equals(_fakeEmail));
      expect(result.image, equals(_fakePhotoUrl));
    });

    test(
      'When [signOut] is called, '
      'then completes without error',
      () async {
        expect(fakeGoogleAuthService.signOut(), completes);

        verify(fakeFirebaseAuth.signOut()).called(1);
      },
    );
  });
}
