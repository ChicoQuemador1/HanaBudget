import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hanabudget/components/expense_tile.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/models/user.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Future<String> _getLoggedInUsername() async {
    var settingsBox = await Hive.openBox('settingsBox');
    return settingsBox.get('loggedInUser', defaultValue: '');
  }

  Future<User?> _getLoggedInUser(String username) async {
    if (username.isNotEmpty) {
      var userBox = Hive.box<User>('userBox');
      return userBox.get(username);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getLoggedInUsername(),
      builder: (context, AsyncSnapshot<String> usernameSnapshot) {
        if (usernameSnapshot.connectionState == ConnectionState.done &&
            !usernameSnapshot.hasError) {
          return FutureBuilder<User?>(
            future: _getLoggedInUser(usernameSnapshot.data!),
            builder: (context, AsyncSnapshot<User?> userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.done &&
                  !userSnapshot.hasError) {
                return _mainContent(
                    context, userSnapshot.data?.firstName ?? 'User');
              } else {
                return const CircularProgressIndicator();
              }
            },
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _mainContent(BuildContext context, String firstName) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(25.0, 20.0, 25.0, 10.0), // Updated padding
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  const Icon(Icons.person, size: 30),
                ],
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Welcome!",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    firstName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
              height: 300), // Added space between user info and expense list
          Expanded(
            child: Consumer<ExpenseData>(
              builder: (context, expenseData, child) => ListView.builder(
                itemCount: expenseData.getAllExpenseList().length,
                itemBuilder: (context, index) {
                  final item = expenseData.getAllExpenseList()[index];
                  return ExpenseTile(
                    name: item.name,
                    amount: item.amount,
                    dateTime: item.dateTime,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
