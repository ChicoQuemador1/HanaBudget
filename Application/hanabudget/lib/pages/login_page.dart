import 'package:flutter/material.dart';
import 'package:hanabudget/components/my_text_field.dart';
import 'package:hanabudget/components/my_button.dart';
import 'package:hanabudget/components/my_button_sign_up.dart';
import 'package:hanabudget/models/user.dart';
import 'package:hive/hive.dart';

class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  LoginPage({super.key});

  void signUserIn(BuildContext context) async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect username or password')),
      );
      return;
    }

    var userBox = Hive.box<User>('userBox');
    var user = userBox.get(usernameController.text);

    if (user != null && user.password == passwordController.text) {
      var settingsBox = await Hive.openBox('settingsBox');
      await settingsBox.put('loggedInUser',
          user.username); // Save the username of the logged-in user
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
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
                          Navigator.pushNamed(context, '/forgot');
                        },
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                MyButton(
                  onTap: () => signUserIn(context),
                ),
                SizedBox(height: 10),
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
