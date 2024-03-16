import 'package:flutter/material.dart';
import 'package:hanabudget/widgets/bottomNavBar.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/loginPage.dart';
import 'screens/homePage.dart';
import 'screens/signupPage.dart';
import 'models/user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<User>('userBox');

  runApp(MyApp());
}

void printSavedCredentials() {
  var box = Hive.box<User>('userBox');
  box.values.forEach((user) {
    print(
        'User: ${user.username}, First Name: ${user.firstName}, Password: ${user.password}');
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HanaBudget',
      theme: ThemeData(),
      home: LoginPage(),
      routes: {
        '/home': (context) => Bottom(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/page1': (context) => ViewExpenses(),
        '/page2': (context) => ViewBudgets(),
        '/page3': (context) => ViewGraphical(),
        '/page4': (context) => SignOutButton(),
      },
    );
  }
}
