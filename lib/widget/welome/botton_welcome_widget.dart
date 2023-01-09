import 'package:flutter/material.dart';

class BottonWelcome extends StatelessWidget {
  const BottonWelcome({
    Key? key,
    required this.color,
    required this.onPressed,
    required this.title,
  }) : super(key: key);
  final String title;
  final Color color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        child: InkWell(
          onTap: onPressed,
          child: Center(
              child: Text(
            title,
            style: TextStyle(color: Colors.white, fontSize: 20),
          )),
        ),
      ),
    );
  }
}
