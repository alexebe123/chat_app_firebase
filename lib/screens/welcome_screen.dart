import 'package:chat_app_firebise/screens/registration_screen.dart';
import 'package:chat_app_firebise/screens/sing_in_screen.dart';
import 'package:flutter/material.dart';

import '../widget/welome/botton_welcome_widget.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const nameRoute = 'welcome-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        SizedBox(
          height: 200,
        ),
        Center(
          child: Container(
            height: 180,
            child: Image.asset('assets/images/message.png'),
          ),
        ),
        Text(
          'Chat App With FireBase',
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue[800],
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 20,
        ),
        BottonWelcome(
          color: Colors.amber[900]!,
          title: 'Sing In',
          onPressed: () {
            Navigator.pushNamed(context, SingInScreen.nameRoute);
          },
        ),
        SizedBox(
          height: 20,
        ),
        BottonWelcome(
          color: Color.fromARGB(255, 10, 87, 160),
          title: 'Regester',
          onPressed: () {
            Navigator.pushNamed(context, RegistrationScreen.nameRoute);
          },
        ),
      ]),
    );
  }
}
