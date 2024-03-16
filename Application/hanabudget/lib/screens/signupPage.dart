import 'package:flutter/material.dart';
import 'package:hanabudget/components/myTextField.dart';
import 'package:hanabudget/components/myButtonSignUp.dart';
import 'package:hanabudget/components/myButton.dart';
import 'package:hanabudget/models/user.dart';
import 'package:hive/hive.dart';

class SignUpPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();

  SignUpPage({super.key});

  void signUp(BuildContext context) async {
    print("signUp method called"); // Debug print

    var box = Hive.box<User>('userBox');
    var user = User(
      username: usernameController.text,
      firstName: nameController.text,
      password: passwordController.text,
    );

    print('User data: ${user.username}, ${user.firstName}'); // Debug print

    await box.put(user.username, user);

    var savedUser = box.get(user.username);
    print(
        'Saved user: ${savedUser?.username}, ${savedUser?.firstName}'); // Debug print

    if (savedUser != null) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      print('Failed to save user');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save user')),
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
                Image.asset(
                  'assets/images/logo.png',
                  width: 300,
                  height: 300,
                ),
                MyTextField(
                  controller: usernameController,
                  hintText: 'Create Username',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: nameController,
                  hintText: 'First Name',
                  obscureText: false,
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: passwordController,
                  hintText: 'Create Password',
                  obscureText: true,
                ),
                SizedBox(height: 15),
                MyButtonSignUp(
                  onTap: () => signUp(context),
                ),
                SizedBox(height: 20),
                Text("Already have an account?"),
                SizedBox(height: 10),
                MyButton(
                  onTap: () {
                    Navigator.pushNamed(context, '/login');
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
