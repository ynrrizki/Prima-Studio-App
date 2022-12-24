// ignore_for_file: overridden_fields

part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  final auth.User? authUser;
  final User? user;
  const AuthState({
    this.authUser,
    this.user,
  });

  @override
  List<Object> get props => [authUser!, user!];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthGoogleLoading extends AuthState {}

class AuthGoogleSuccess extends AuthState {
  // @override
  // final User? user;

  // const AuthGoogleSuccess(this.user);

  // @override
  // List<Object> get props => [authUser!];
}

class AuthSuccess extends AuthState {}

class AuthFailed extends AuthState {
  final String error;

  const AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}

class AuthUser extends AuthState {
  @override
  final User user;

  const AuthUser(this.user);

  @override
  List<Object> get props => [user];
}
