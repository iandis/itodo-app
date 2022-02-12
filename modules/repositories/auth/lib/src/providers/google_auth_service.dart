import 'package:auth/src/providers/google_auth_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide GoogleAuthProvider;
import 'package:google_sign_in/google_sign_in.dart';

import '../entities/auth_result.dart';

class GoogleAuthService {
  const GoogleAuthService({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
    required GoogleAuthProvider googleAuthProvider,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn,
        _googleAuthProvider = googleAuthProvider;

  factory GoogleAuthService.create() {
    return GoogleAuthService(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn(),
      googleAuthProvider: const GoogleAuthProvider(),
    );
  }

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final GoogleAuthProvider _googleAuthProvider;

  Stream<AuthResult?> get currentSession async* {
    final Stream<User?> sessionStream = _firebaseAuth.authStateChanges();
    await for (final User? currentSession in sessionStream) {
      AuthResult? result;
      if (currentSession != null) {
        result = AuthResult(
          id: currentSession.uid,
          name: currentSession.displayName,
          email: currentSession.email,
          image: currentSession.photoURL,
          token: await currentSession.getIdToken(true),
          isNewUser: false,
        );
      }
      yield result;
    }
  }

  Future<AuthResult?> getCurrentSession() async {
    final User? currentSession = await _firebaseAuth.authStateChanges().first;
    if (currentSession != null) {
      final AuthResult result = AuthResult(
        id: currentSession.uid,
        name: currentSession.displayName,
        email: currentSession.email,
        image: currentSession.photoURL,
        token: await currentSession.getIdToken(true),
        isNewUser: false,
      );
      return result;
    }
  }

  Future<AuthResult?> signIn() async {
    final GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();

    if (signInAccount != null) {
      final GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;

      final AuthCredential credential = _googleAuthProvider.create(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final AuthResult authResult = AuthResult(
        id: userCredential.user!.uid,
        isNewUser: userCredential.additionalUserInfo!.isNewUser,
        token: await userCredential.user!.getIdToken(true),
        name: userCredential.user!.displayName,
        email: userCredential.user!.email,
        image: userCredential.user!.photoURL,
      );

      return authResult;
    }
  }

  Future<AuthResult> signUp({
    required String email,
    required String password,
  }) async {
    final UserCredential credential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);

    final AuthResult authResult = AuthResult(
      id: credential.user!.uid,
      isNewUser: credential.additionalUserInfo!.isNewUser,
      token: await credential.user!.getIdToken(),
      name: credential.user!.displayName,
      email: credential.user!.email,
      image: credential.user!.photoURL,
    );

    return authResult;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}
