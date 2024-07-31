import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/core/commons/widgets/loader.dart';
import 'package:flutter_clean_architecture/core/utils/show_snack_bar.dart';
import 'package:flutter_clean_architecture/features/auth/persentation/bloc/auth_bloc.dart';
import 'package:flutter_clean_architecture/features/auth/persentation/widgets/auth_button.dart';
import 'package:flutter_clean_architecture/features/auth/persentation/widgets/auth_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final formKey = GlobalKey<FormState>();

  final nameContoller = TextEditingController();
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthFailur) {
              showSnackbar(context, state.message);
            }
            if (state is AuthSucces) {
              showSnackbar(context, state.user.name);
            }
          },
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Loader();
            }

            return SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    const Text(
                      'Sign Up',
                      style:
                          TextStyle(fontSize: 48, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    AuthField(controller: nameContoller, hintText: "Name"),
                    const SizedBox(
                      height: 12,
                    ),
                    AuthField(controller: emailContoller, hintText: "Email"),
                    const SizedBox(
                      height: 12,
                    ),
                    AuthField(
                      controller: passwordContoller,
                      hintText: "Password",
                      isObjSecure: true,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    AuthButton(
                        text: "Sign Up",
                        onTap: () {
                          if (!formKey.currentState!.validate()) return;
                          context.read<AuthBloc>().add(AuthSignUp(
                              name: nameContoller.text,
                              email: emailContoller.text,
                              password: passwordContoller.text));
                        })
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
