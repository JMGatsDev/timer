import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import './auth_service.dart';

class AuthServiceImpl implements AuthService {
  @override
  Future<void> singIn() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Future<void> singOut() async {
    await FirebaseAuth.instance.signOut();
    GoogleSignIn().disconnect();
  }
}
