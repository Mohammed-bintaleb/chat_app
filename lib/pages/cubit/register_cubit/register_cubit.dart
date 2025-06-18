import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  Future<void> registerUser({
    required String email,
    required String password,
  }) async {
    emit(RegisterLoading());
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      emit(RegisterSuccess());
    } on FirebaseAuthException catch (ex) {
      String errorMessage;
      if (ex.code == 'weak-password') {
        errorMessage = 'Weak password';
      } else if (ex.code == 'email-already-in-use') {
        errorMessage = "Email already in use";
      } else {
        errorMessage = "Authentication error: ${ex.message}";
      }
      emit(RegisterFailure(errMassage: errorMessage));
    } catch (e) {
      emit(RegisterFailure(errMassage: "Something went wrong"));
    }
  }
}
