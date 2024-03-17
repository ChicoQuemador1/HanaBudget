import 'package:flutter/material.dart';
import 'package:hanabudget/components/my_text_field.dart';
import 'package:hanabudget/components/my_button_sign_up.dart';
import 'package:hanabudget/components/my_button.dart';
import 'package:hanabudget/models/user.dart';
import 'package:hive/hive.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final securityAnswerController = TextEditingController();
  String? selectedSecurityQuestion;

  final List<String> securityQuestions = [
    'What is your mother’s maiden name?',
    'What was your first pet’s name?',
    'What was the model of your first car?',
    'In what town was your first job?',
    'What is the name of the school you attended for sixth grade?',
  ];

  void signUp(BuildContext context) async {
    if (usernameController.text.isEmpty ||
        passwordController.text.isEmpty ||
        nameController.text.isEmpty ||
        securityAnswerController.text.isEmpty ||
        selectedSecurityQuestion == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in all fields')),
      );
      return;
    }

    var box = Hive.box<User>('userBox');
    var user = User(
      username: usernameController.text,
      firstName: nameController.text,
      password: passwordController.text,
      securityQuestion: selectedSecurityQuestion!,
      securityAnswer: securityAnswerController.text,
    );

    await box.put(user.username, user);

    var settingsBox = await Hive.openBox('settingsBox');
    await settingsBox.put('loggedInUser', user.username);

    var savedUser = box.get(user.username);
    if (savedUser != null) {
      // Force UI update to display correct first name
      setState(() {});

      // Navigate to home page with the user's first name as a route argument
      Navigator.pushReplacementNamed(context, '/home',
          arguments: savedUser.firstName);
    } else {
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
                  'assets/images/tinylogo.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 50),
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
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: DropdownButtonFormField<String>(
                    isExpanded: true,
                    value: selectedSecurityQuestion,
                    hint: Text("Select a Security Question"),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedSecurityQuestion = newValue;
                      });
                    },
                    items: securityQuestions
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                MyTextField(
                  controller: securityAnswerController,
                  hintText: 'Security Answer',
                  obscureText: false,
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
