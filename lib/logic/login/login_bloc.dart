import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'login_event.dart';
part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutRequested>(_onLogoutRequested);
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) {
    if (event.username.isNotEmpty && event.password.length >= 6) {
      emit(AuthAuthenticated());
    } else {
      emit(const AuthError('Invalid username or password'));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(AuthInitial());
  }
}