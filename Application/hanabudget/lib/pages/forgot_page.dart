import 'package:flutter/material.dart';
import 'package:hanabudget/components/my_text_field.dart';
import 'package:hanabudget/components/my_button_forgot.dart';
import 'package:hanabudget/models/user.dart';
import 'package:hive/hive.dart';

class ForgotPage extends StatefulWidget {
  ForgotPage({super.key});

  @override
  _ForgotPageState createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final usernameController = TextEditingController();
  final answerController = TextEditingController();
  final newPasswordController = TextEditingController();
  String? selectedSecurityQuestion;

  final List<String> securityQuestions = [
    'What is your mother’s maiden name?',
    'What was your first pet’s name?',
    'What was the model of your first car?',
    'In what town was your first job?',
    'What is the name of the school you attended for sixth grade?',
  ];

  void verifyAndUpdatePassword(BuildContext context) async {
    var box = Hive.box<User>('userBox');
    var user = box.get(usernameController.text);

    if (user != null &&
        user.securityQuestion == selectedSecurityQuestion &&
        user.securityAnswer == answerController.text) {
      user.password = newPasswordController.text; // Update the password
      await box.put(user.username, user); // Save the updated user
      Navigator.pushReplacementNamed(context, '/home'); // Navigate to home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Incorrect username or security question')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/tinylogo.png',
                  width: 100, height: 100),
              SizedBox(height: 20),
              MyTextField(
                controller: usernameController,
                hintText: 'Username',
                obscureText: false,
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
                controller: answerController,
                hintText: 'Answer to Security Question',
                obscureText: false,
              ),
              SizedBox(height: 20),
              MyTextField(
                controller: newPasswordController,
                hintText: 'New Password',
                obscureText: true,
              ),
              SizedBox(height: 20),
              MyButtonForgot(
                onTap: () => verifyAndUpdatePassword(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
