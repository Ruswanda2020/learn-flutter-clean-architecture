part of 'auth_bloc.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSucces extends AuthState {
  final User user;

  AuthSucces({required this.user});
}

final class AuthFailur extends AuthState {
  final String message;

  AuthFailur({required this.message});
}
