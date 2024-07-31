import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecase/user_signup.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserSignup _userSignup;

  AuthBloc({required UserSignup userSignup})
      : _userSignup = userSignup,
        super(AuthInitial()) {
    on<AuthSignUp>(_onAuthSignUp);
  }

  FutureOr<void> _onAuthSignUp(
      AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final respons = await _userSignup(UserSignupParam(
      name: event.name,
      email: event.email,
      password: event.password,
    ));
    respons.fold(
        (failure) => emit(AuthFailur(message: failure.message)),
        (user) => emit(
              AuthSucces(user: user),
            ));
  }
}
