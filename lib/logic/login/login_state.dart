part of 'login_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthAuthenticated extends AuthState {}

class AuthError extends AuthState {
  final String errorMessage;

  const AuthError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}