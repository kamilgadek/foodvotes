import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../cubit/root_cubit.dart';

class MyAccountPageContent extends StatelessWidget {
  const MyAccountPageContent({
    Key? key,
    required this.email,
  }) : super(key: key);

  final String? email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text('Jesteś zalogowany jako $email'),
        ),
        const SizedBox(
          height: 25,
        ),
        ElevatedButton(
          onPressed: () {
            context.read<RootCubit>().signOut();
          },
          child: const Text('Wyloguj się'),
        ),
      ],
    );
  }
}
