import 'package:flutter/material.dart';
import 'package:hanabudget/components/expense_summary.dart';
import 'package:hanabudget/components/expense_tile.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/models/expense_item.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  Widget expenseList() {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
                body: ListView(children: [
              ExpenseSummary(startOfWeek: value.startOfWeekDate()),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: value.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: value.getAllExpenseList()[index].name,
                  amount: value.getAllExpenseList()[index].amount,
                  dateTime: value.getAllExpenseList()[index].dateTime,
                ),
              ),
            ])));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
          child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              Row(children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.yellow[700]),
                    ),
                    Icon(Icons.person, color: Colors.yellow[800])
                  ],
                ),
                const SizedBox(width: 8),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(
                    "Welcome!",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ]),
              ])
            ]),
          ])),
    );
  }
}
