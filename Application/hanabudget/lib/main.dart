import 'package:flutter/material.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/screens/graph_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
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
  await Hive.openBox('settingsBox');
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
    return ChangeNotifierProvider(
      create: (context) => ExpenseData(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'HanaBudget',
        theme: ThemeData(),
        home: LoginPage(),
        routes: {
          '/home': (context) => HomePage(),
          '/login': (context) => LoginPage(),
          '/signup': (context) => SignUpPage(),
          '/forgot': (context) => ForgotPage(),
          '/graph': (context) => GraphPage(),
        },
      ),
    );
  }
}
