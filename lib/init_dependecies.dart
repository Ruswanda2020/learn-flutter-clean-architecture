import 'package:flutter_clean_architecture/core/secrets/app_secrets.dart';
import 'package:flutter_clean_architecture/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:flutter_clean_architecture/features/auth/data/repository/auth_repository_impl.dart';
import 'package:flutter_clean_architecture/features/auth/domain/repository/auth_repository.dart';
import 'package:flutter_clean_architecture/features/auth/domain/usecase/user_signup.dart';
import 'package:flutter_clean_architecture/features/auth/persentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  final supaBase = await Supabase.initialize(
      url: AppSecrets.supabaseUrl, anonKey: AppSecrets.supabaseApiKey);

  serviceLocator.registerLazySingleton(() => supaBase.client);
  _initAuth();
}

void _initAuth() {
  serviceLocator

    //datasource
    ..registerFactory<AuthRemoteDatasource>(() => AuthRemoteDatasourceImpl(
          supabaseClient: serviceLocator(),
        ))
    //repository
    ..registerFactory<AuthRepository>(() => AuthRepositoryImpl(
              authRemoteDatasource: serviceLocator(),
            )
        //usecase
        )
    ..registerFactory(
      () => UserSignup(
        authRepository: serviceLocator(),
      ),
    )
    //bloc
    ..registerFactory(
      () => AuthBloc(
        userSignup: serviceLocator(),
      ),
    );
}
