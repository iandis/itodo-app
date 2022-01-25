import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../entities/auth_result.dart';

class GoogleAuthService {
  const GoogleAuthService({
    required FirebaseAuth firebaseAuth,
    required GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth,
        _googleSignIn = googleSignIn;

  factory GoogleAuthService.create() {
    return GoogleAuthService(
      firebaseAuth: FirebaseAuth.instance,
      googleSignIn: GoogleSignIn(),
    );
  }

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  Future<AuthResult?> signIn() async {
    final GoogleSignInAccount? signInAccount = await _googleSignIn.signIn();

    if (signInAccount != null) {
      final GoogleSignInAuthentication signInAuthentication =
          await signInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: signInAuthentication.accessToken,
        idToken: signInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await _firebaseAuth.signInWithCredential(credential);

      final AuthResult authResult = AuthResult(
        id: userCredential.user!.uid,
        isNewUser: userCredential.additionalUserInfo!.isNewUser,
        token: signInAuthentication.idToken,
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
