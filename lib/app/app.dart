import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:najlepsza_pizza_w_miescie/app/cubit/root_cubit.dart';
import 'package:flutter/material.dart';
import 'package:najlepsza_pizza_w_miescie/app/home/home_page.dart';
import 'package:najlepsza_pizza_w_miescie/app/login/login_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            scaffoldBackgroundColor: const Color.fromARGB(255, 214, 214, 214)),
        home: const RootPage());
  }
}

class RootPage extends StatelessWidget {
  const RootPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RootCubit()..start(),
      child: BlocBuilder<RootCubit, RootState>(
        builder: (context, state) {
          final user = state.user;
          if (user == null) return LoginPage();

          return HomePage(user: user);
        },
      ),
    );
  }
}
