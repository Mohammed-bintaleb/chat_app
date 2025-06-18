import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

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
