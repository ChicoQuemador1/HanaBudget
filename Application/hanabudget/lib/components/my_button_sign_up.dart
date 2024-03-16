import 'package:flutter/material.dart';

class MyButtonSignUp extends StatelessWidget {
  final Function()? onTap;
  const MyButtonSignUp({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(25.0),
        margin: EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 189, 188, 188),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Center(
          child: Text("Sign Up",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16)),
        ),
      ),
    );
  }
}
