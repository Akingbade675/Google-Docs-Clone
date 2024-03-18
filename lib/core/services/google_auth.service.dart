import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn;

  GoogleAuthService(this._googleSignIn);

  void signIn() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      //
      if (googleUser == null) {
        throw 'Google signin failed';
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
    } catch (error) {
      rethrow;
    }
  }
}
