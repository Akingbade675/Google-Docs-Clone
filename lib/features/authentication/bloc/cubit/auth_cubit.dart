import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_docs_clone/core/services/secure_storage_service.dart';
import 'package:google_docs_clone/features/authentication/models/user_model.dart';
import 'package:google_docs_clone/features/authentication/repository/auth_repository.dart';
import 'package:google_docs_clone/features/documents/models/document.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SecureStorageService _secureStorageService = SecureStorageService();
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthLoading());

  void appStarted() async {
    try {
      final String token = await _secureStorageService.getToken();
      if (token.isNotEmpty) {
        final (user, document) = await _authRepository.getUserData(token);
        emit(AuthAuthenticated(user: user, userDocuments: document));
      } else {
        emit(AuthUnauthenticated());
      }
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
      // emit(AuthUnauthenticated());
    }
  }

  void signIn() async {
    try {
      final User? user = await _authRepository.signInWithGoogle();
      if (user != null) {
        await _secureStorageService.persistToken(user.token);
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthUnauthenticated());
      }
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  void signOut() async {
    await _authRepository.signOut();
    await _secureStorageService.deleteToken();
    emit(AuthUnauthenticated());
  }
}
