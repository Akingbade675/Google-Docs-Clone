import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:google_docs_clone/features/authentication/models/user_model.dart';
import 'package:google_docs_clone/features/authentication/repository/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;
  AuthCubit(this._authRepository) : super(AuthUnauthenticated());

  void signIn() async {
    try {
      final User? user = await _authRepository.signInWithGoogle();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
