import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/simple_bloc_observer.dart';
import 'package:chat_app/view_model/bloc/auth_bloc/auth_bloc.dart';
import 'package:chat_app/view_model/chat_cubit/chat_cubit.dart';
import 'package:chat_app/view/auth/login_page.dart';
import 'package:chat_app/view/auth/register_page.dart';
import 'view/chat/chat_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Bloc.observer = SimpleBlocObserver();

  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ChatCubit()),
        BlocProvider(create: (_) => AuthBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: LoginPage.screenRoute,
        routes: {
          LoginPage.screenRoute: (context) => LoginPage(),
          RegisterPage.screenRoute: (context) => RegisterPage(),
          ChatPage.screenRoute: (context) => ChatPage(),
        },
      ),
    );
  }
}
