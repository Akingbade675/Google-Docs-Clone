// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'auth_cubit.dart';

@immutable
sealed class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthAuthenticated extends AuthState {
  final User user;
  final List<Document> userDocuments;

  AuthAuthenticated({
    this.userDocuments = const [],
    required this.user,
  });

  AuthAuthenticated copyWith({
    User? user,
    List<Document>? userDocuments,
  }) {
    return AuthAuthenticated(
      user: user ?? this.user,
      userDocuments: userDocuments ?? this.userDocuments,
    );
  }

  @override
  List<Object> get props => [user, userDocuments];
}

final class AuthUnauthenticated extends AuthState {}

final class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

final class AuthLoading extends AuthState {}
