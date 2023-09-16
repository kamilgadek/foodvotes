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
                child: Padding(
                  padding: const EdgeInsets.all(12.70),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                    offset: const Offset(53, -8),
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
                                    fontSize:
                                        48, // Dostosuj rozmiar czcionki do obrazka
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 80),
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
                      const SizedBox(height: 20),
                      //Login textfield
                      TextField(
                        decoration: InputDecoration(
                            hintText: 'email',
                            hintStyle: GoogleFonts.nunito(
                              textStyle: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            filled: true, 
                            fillColor: Colors.white.withAlpha(100),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 30.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                            )),
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      //Register textfield
                      const SizedBox(height: 20),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'hasło',
                          hintStyle: GoogleFonts.nunito(
                            textStyle: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          filled: true, 
                          fillColor: Colors.white.withAlpha(100),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 30),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              width: 10.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
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
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
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
                              child: Text(
                                state.isCreatingAccount
                                    ? 'Zarejestruj się'
                                    : 'Zaloguj się',
                                style: GoogleFonts.nunito(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withAlpha(100),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 60),
                      if (state.isCreatingAccount == false) ...[
                        TextButton(
                          onPressed: () {
                            context
                                .read<RootCubit>()
                                .createAccountButtonPressed();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Nie masz u Nas konta?',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Zarejestruj się',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xFFFF7269),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                      if (state.isCreatingAccount == true) ...[
                        TextButton(
                          onPressed: () {
                            context.read<RootCubit>().signInButtonPressed();
                          },
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Masz już konto?',
                              style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white,
                                  ), 
                              ),
                              Text(
                                'Zaloguj się',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  color: Color(0xFFFF7269),
                                ),
                              ),
                            ],
                          ),
                          
                        ),
                      ],
                    ],
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
