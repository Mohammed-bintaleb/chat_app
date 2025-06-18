import 'package:chat_app/pages/cubit/auth_cubit/auth_cubit.dart';
import 'package:chat_app/pages/cubit/chat_cubit/chat_cubit.dart';
import 'package:chat_app/pages/login_page.dart';
import 'package:chat_app/pages/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/chat_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyCuNJsl2DaHgUpc_9ZG58rrvHWtAts1tSw",
      authDomain: "chat-app-a220d.firebaseapp.com",
      projectId: "chat-app-a220d",
      storageBucket: "chat-app-a220d.firebasestorage.app",
      messagingSenderId: "78028916490",
      appId: "1:78028916490:web:9819bc4ff79d151d7ddcf3",
      measurementId: "G-GJWW7WH7T5",
    ),
  );
  runApp(const ScholarChat());
}

class ScholarChat extends StatelessWidget {
  const ScholarChat({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(create: (_) => ChatCubit()),
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
