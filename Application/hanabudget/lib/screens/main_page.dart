import 'package:flutter/material.dart';
import 'package:hanabudget/components/expense_tile.dart';
import 'package:hive/hive.dart';
import 'package:hanabudget/models/user.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Box>(
      future: Hive.openBox('settingsBox'),
      builder: (context, AsyncSnapshot<Box> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            !snapshot.hasError) {
          var settingsBox = snapshot.data!;
          var loggedInUsername =
              settingsBox.get('loggedInUser', defaultValue: '');

          if (loggedInUsername != '') {
            var userBox = Hive.box<User>('userBox');
            var user = userBox.get(loggedInUsername);

            if (user != null) {
              return userMainScreen(user.firstName);
            }
          }

          return userMainScreen('User');
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget userMainScreen(String firstName) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
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
                            shape: BoxShape.circle, color: Colors.white),
                      ),
                      const Icon(
                        Icons.person,
                        size: 30,
                      )
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      Text(
                        firstName, // Display the first name
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                  ListView(children: [
                    //ExpenseSummary(startOfWeek: value.startOfWeekDate()),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value.getAllExpenseList().length,
                        itemBuilder: (context, index) => ExpenseTile(
                            name: value.getAllExpenseList()[index].name,
                            amount: value.getAllExpenseList()[index].amount,
                            dateTime:
                                value.getAllExpenseList()[index].dateTime)),
                  ]),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
