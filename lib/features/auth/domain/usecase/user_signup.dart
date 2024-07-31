import 'package:either_dart/either.dart';
import 'package:flutter_clean_architecture/core/error/failure.dart';
import 'package:flutter_clean_architecture/core/usecase/usecase.dart';
import 'package:flutter_clean_architecture/features/auth/domain/entities/user.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repository/auth_repository.dart';

class UserSignup implements Usecase<User, UserSignupParam> {
  final AuthRepository authRepository;

  UserSignup({required this.authRepository});
  @override
  Future<Either<Failure, User>> call(UserSignupParam params) {
    return authRepository.signUpWithEmailAndPassword(
      name: params.name,
      email: params.email,
      password: params.password,
    );
  }
}

class UserSignupParam {
  final String name;
  final String email;
  final String password;

  UserSignupParam({
    required this.name,
    required this.email,
    required this.password,
  });
}
