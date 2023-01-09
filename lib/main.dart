// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'screens/chat_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/sing_in_screen.dart';
import 'screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _auth = FirebaseAuth.instance;
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: ChatScreen(),
      initialRoute: _auth.currentUser != null
          ? ChatScreen.nameRoute
          : WelcomeScreen.nameRoute,
      routes: {
        WelcomeScreen.nameRoute: (context) => WelcomeScreen(),
        SingInScreen.nameRoute: (context) => SingInScreen(),
        RegistrationScreen.nameRoute: (context) => RegistrationScreen(),
        ChatScreen.nameRoute: (context) => ChatScreen()
      },
    );
  }
}
