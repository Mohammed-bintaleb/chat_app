import 'package:chat_app/constants.dart';
import 'package:chat_app/helper/show_snack_bar.dart';
import 'package:chat_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:chat_app/view/auth/login_page.dart';
import 'package:chat_app/widgets/custom_button.dart';
import 'package:chat_app/widgets/custom_form_text_field.dart';
import 'package:chat_app/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

// ignore: must_be_immutable
class RegisterPage extends StatelessWidget {
  static const String screenRoute = "RegisterPage";
  String? email;
  String? password;
  bool isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          Navigator.pushNamed(context, LoginPage.screenRoute);
        } else if (state is RegisterFailure) {
          showSnackBar(context, state.errMassage);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is RegisterLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Form(
                key: formKey,
                child: ListView(
                  children: [
                    const SizedBox(height: 75),
                    Image.asset('assets/images/scholar.png', height: 100),
                    Row(
                      children: const [
                        CustomText(
                          text: 'Scholar Chat',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'pacifico',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 75),
                    Row(
                      children: const [
                        CustomText(
                          text: 'REGISTER',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomFormTextField(
                      onChanged: (data) {
                        email = data;
                      },
                      hintText: 'Email',
                    ),
                    const SizedBox(height: 10),
                    CustomFormTextField(
                      obscureText: true,
                      onChanged: (data) {
                        password = data;
                      },
                      hintText: 'Password',
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          BlocProvider.of<AuthCubit>(
                            context,
                          ).registerUser(email: email!, password: password!);
                        } else {}
                      },

                      text: 'REGISTER',
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: 'already have an account?',
                          style: const TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: CustomText(
                            text: 'Login',
                            style: const TextStyle(color: Color(0xffC7EDE6)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
