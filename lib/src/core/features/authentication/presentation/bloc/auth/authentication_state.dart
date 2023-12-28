// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'authentication_bloc.dart';

enum AuthStatus {
  unknown,
  authenticated,
  unauthenticated,
}

class AuthState extends Equatable {
  final AuthStatus authStatus;
  final fbauth.User? user;
  const AuthState({
    required this.authStatus,
    this.user,
  });

  factory AuthState.unknown() {
    return const AuthState(authStatus: AuthStatus.unknown);
  }

  @override
  List<Object?> get props => [authStatus, user];

  @override
  String toString() => 'AuthState(authStatus: $authStatus, user: $user)';

  AuthState copyWith({
    AuthStatus? authStatus,
    fbauth.User? user,
  }) {
    return AuthState(
      authStatus: authStatus ?? this.authStatus,
      user: user ?? this.user,
    );
  }
}
