import 'package:flutter/material.dart';
import 'package:hanabudget/components/myTextField.dart';
import 'package:hanabudget/components/myButton.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  void signUserIn() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                // logo
                const SizedBox(height: 10),
                const Icon(
                  Icons.attach_money,
                  size: 100,
                ),
                // welcome back
                const SizedBox(height: 10),
                Text(
                  'Welcome, ready to save money?',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 16,
                  ),
                ),
                // username
                const SizedBox(height: 10),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                // password
                const SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                // forgot password?
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                // sign in
                const SizedBox(height: 25),
                MyButton(
                  onTap: signUserIn,
                ),
                // register
              ],
            ),
          ),
        ));
  }
}
