import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  Future<void> loginUser({
    required String email,
    required String password,
  }) async {
    emit(LoginLoading());
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(LoginSuccess());
    } on FirebaseAuthException catch (ex) {
      String errorMessage;
      if (ex.code == 'user-not-found') {
        errorMessage = "User not found";
      } else if (ex.code == 'wrong-password') {
        errorMessage = "Wrong password";
      } else {
        errorMessage = "Authentication error: ${ex.message}";
      }
      emit(LoginFailure(errMassage: errorMessage));
    } catch (e) {
      emit(LoginFailure(errMassage: "Something went wrong. Please try again."));
    }
  }
}
