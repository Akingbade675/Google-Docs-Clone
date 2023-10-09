// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:flutter/foundation.dart';
import 'package:google_docs_clone/features/authentication/models/user_model.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required GoogleSignIn googleSignIn,
  }) : _googleSignIn = googleSignIn;

  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? user = await _googleSignIn.signIn();
    if (user != null) {
      print(user.id);
      print(user.email);
      print(user.displayName);
      print(user.photoUrl);
      return User(
        id: user.id,
        email: user.email,
        name: user.displayName ?? '',
        photoUrl: user.photoUrl ?? '',
      );
    }
    return null;
  }
}
