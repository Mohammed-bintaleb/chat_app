import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(LoginLoading());
        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(LoginSuccess());
        } on FirebaseAuthException catch (ex) {
          print('FirebaseAuthException code: ${ex.code}');
          String errorMessage;
          if (ex.code == 'invalid-email') {
            errorMessage = "Invalid email";
          } else if (ex.code == 'invalid-credential') {
            errorMessage = "Wrong password";
          } else {
            errorMessage = "Authentication error: ${ex.message}";
          }
          emit(LoginFailure(errMassage: errorMessage));
        } catch (e) {
          emit(
            LoginFailure(errMassage: "Something went wrong. Please try again."),
          );
        }
      } else if (event is RegisterEvent) {
        emit(RegisterLoading());
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: event.email,
            password: event.password,
          );
          emit(RegisterSuccess());
        } on FirebaseAuthException catch (ex) {
          print('FirebaseAuthException code: ${ex.code}');
          String errorMessage;
          if (ex.code == 'invalid-email') {
            errorMessage = 'Invalid-email';
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
    });
  }
}
