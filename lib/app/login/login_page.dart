import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../cubit/root_cubit.dart';

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
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.8), BlendMode.dstATop),
                    image: const AssetImage('images/tlo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(12.70),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            RichText(
                              text: TextSpan(
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 48,
                                  color: Colors.white,
                                  shadows: [
                                    const Shadow(
                                      offset: Offset(4.0, 4.0),
                                      blurRadius: 2.0,
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                                children: [
                                  WidgetSpan(
                                    child: Transform.translate(
                                      offset: Offset(53, -8),
                                    child: Transform.rotate(
                                      angle: 33.27 / 180.0,
                                      child: Image.asset(
                                        'images/Chef-Hat.png',
                                      ),
                                    ),
                                  ),
                                  ),
                                 const TextSpan(
                        text: 'Food Votes', // Bez litery "F"
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFFC7DFF1),
                          decorationThickness: 4.0,
                          decorationStyle: TextDecorationStyle.solid,
                          fontSize: 48, // Dostosuj rozmiar czcionki do obrazka
                        ),
                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          state.isCreatingAccount == true
                              ? 'Zarejestruj się'
                              : 'Zaloguj się',
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            color: Colors.white,
                          ),
                        ),
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
              ),
            ),
          );
        },
      ),
    );
  }
}
