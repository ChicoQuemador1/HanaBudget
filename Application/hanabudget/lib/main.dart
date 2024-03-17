import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/login_page.dart';
import 'screens/sign_up_page.dart';
import 'models/user.dart';
import 'screens/forgot_page.dart';
import 'screens/home_page.dart';

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
        '/home': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/forgot': (context) => ForgotPage(),
      },
    );
  }
}
