import 'package:firebase_auth/firebase_auth.dart' as firebase;

class GoogleAuthProvider {
  const GoogleAuthProvider();

  firebase.AuthCredential create({
    required String? accessToken,
    required String? idToken,
  }) {
    return firebase.GoogleAuthProvider.credential(
      accessToken: accessToken,
      idToken: idToken,
    );
  }
}
