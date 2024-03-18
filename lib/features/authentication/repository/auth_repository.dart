// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'dart:convert';

import 'package:google_docs_clone/core/repository/http_client.dart';
import 'package:google_docs_clone/features/authentication/models/user_model.dart';
import 'package:google_docs_clone/features/documents/models/document.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final GoogleSignIn _googleSignIn;
  final HttpClient _client;

  AuthRepository({
    required GoogleSignIn googleSignIn,
    required HttpClient client,
  })  : _googleSignIn = googleSignIn,
        _client = client;

  Future<User?> signInWithGoogle() async {
    GoogleSignInAccount? user = await _googleSignIn.signIn();
    if (user != null) {
      final response = await _client.post('auth/signup', body: {
        'id': user.id,
        'email': user.email,
        'name': user.displayName ?? '',
        'photoUrl': user.photoUrl ?? '',
      });
      return User.fromJson(response);
    }
    return null;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  Future<(User, List<Document>)> getUserData(String token) async {
    // final user = _googleSignIn.currentUser;
    // if (user != null) {
    var response = await _client.get(
      'auth/me',
      token: token,
    );
    final documents = List<Document>.from(
      jsonDecode(response)['documents'].map(
        (x) => Document.fromMap(x),
      ),
    );
    final user = User.fromJson(response);
    return (user, documents);
    // }
  }
}
