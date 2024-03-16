import 'package:flutter/material.dart';
import 'package:hanabudget/components/myTextField.dart';
import 'package:hanabudget/components/myButton.dart';
import 'package:hanabudget/components/myButtonSignUp.dart';
import 'package:hanabudget/models/user.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  void signUserIn(BuildContext context) async {
    var box = Hive.box<User>('userBox');
    var user = box.get(usernameController.text);

    if (user != null && user.password == passwordController.text) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect username or password')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Image.asset(
                  'assets/images/logo.png',
                  width: 400,
                  height: 400,
                ),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: Implement forgot password functionality
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                MyButton(
                  onTap: () => signUserIn(context),
                ),
                SizedBox(height: 20),
                Text("Don't have an account?"),
                SizedBox(height: 10),
                MyButtonSignUp(
                  onTap: () {
                    Navigator.pushNamed(context, '/signup');
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
