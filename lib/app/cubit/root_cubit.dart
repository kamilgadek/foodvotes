import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

part 'root_state.dart';

class RootCubit extends Cubit<RootState> {
  RootCubit()
      : super(
          const RootState(
            user: null,
            isLoading: false,
            isCreatingAccount: false,
            errorMessage: '',
          ),
        );

  StreamSubscription? _streamSubscription;

  Future<void> createAccountButtonPressed() async {
    emit(
      const RootState(
        user: null,
        isLoading: false,
        errorMessage: '',
        isCreatingAccount: true,
      ),
    );
  }

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'email-already-in-use') {
        emit(
          const RootState(
              errorMessage: "Takie konto już istnieje! ",
              isLoading: false,
              user: null,
              isCreatingAccount: false),
        );
      }
    }
  }

  Future<void> signInButtonPressed() async {
    emit(
      const RootState(
        user: null,
        isLoading: false,
        errorMessage: '',
        isCreatingAccount: false,
      ),
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      if (error.code == 'user-not-found') {
        emit(
          const RootState(
              errorMessage: 'Nie znaloziono takiego użtkownika',
              isLoading: false,
              user: null,
              isCreatingAccount: false),
        );
      } else if (error.code == 'wrong-password') {
        emit(
          const RootState(
              errorMessage: 'Błędne hasło',
              isLoading: false,
              user: null,
              isCreatingAccount: false),
        );
      }
    }
  }

  Future<void> signOut() async {
    FirebaseAuth.instance.signOut();
  }

  Future<void> start() async {
    emit(
      const RootState(
        user: null,
        isLoading: true,
        isCreatingAccount: false,
        errorMessage: '',
      ),
    );

    _streamSubscription =
        FirebaseAuth.instance.authStateChanges().listen((user) {
      emit(const RootState(
        user: null,
        isLoading: false,
        isCreatingAccount: false,
        errorMessage: '',
      ));
    })
          ..onError((error) {
            emit(
              RootState(
                user: null,
                isLoading: false,
                isCreatingAccount: false,
                errorMessage: error.toString(),
              ),
            );
          });
  }

  @override
  Future<void> close() {
    _streamSubscription?.cancel();
    return super.close();
  }
}
