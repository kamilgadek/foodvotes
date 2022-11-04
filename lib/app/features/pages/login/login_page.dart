import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/root_cubit.dart';

class LoginPage extends StatelessWidget {
  LoginPage({
    Key? key,
  }) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.isCreatingAccount == true
                        ? 'Zarejestruj się'
                        : 'Zaloguj się'),
//Login textfield
                    TextField(
                      decoration: const InputDecoration(hintText: 'Login'),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                    ),
//Register textfield
                    TextField(
                      decoration: const InputDecoration(hintText: 'Hasło'),
                      controller: passwordController,
                      obscureText: true,
                    ),
//
                    const SizedBox(
                      height: 20,
                    ),
                    Text(state.errorMessage),
                    const SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (state.isCreatingAccount == false) {
//Login
                          await context.read<RootCubit>().signIn(
                                emailController.text,
                                passwordController.text,
                              );
//Register
                        } else {
                          await context.read<RootCubit>().register(
                                emailController.text,
                                passwordController.text,
                              );
                        }
                      },
                      child: Text(state.isCreatingAccount
                          ? 'Zarejestruj się'
                          : 'Zaloguj się'),
                    ),
                    const SizedBox(height: 20),
                    if (state.isCreatingAccount == false) ...[
                      TextButton(
                        onPressed: () {
                          context
                              .read<RootCubit>()
                              .createAccountButtonPressed();
                        },
                        child: const Text('Utwórz konto'),
                      )
                    ],
                    if (state.isCreatingAccount == true) ...[
                      TextButton(
                        onPressed: () {
                          context.read<RootCubit>().signInButtonPressed();
                        },
                        child: const Text('Masz już konto?'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
