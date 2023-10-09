// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthAuthenticated extends AuthState {
  final User user;

  AuthAuthenticated({
    required this.user,
  });

  AuthAuthenticated copyWith({
    User? user,
    String? token,
  }) {
    return AuthAuthenticated(
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [user];
}

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
