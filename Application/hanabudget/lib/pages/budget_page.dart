import 'package:flutter/material.dart';
import 'package:hanabudget/data/budget_data.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/models/budget_item.dart';
import 'package:hanabudget/models/expense_item.dart';
import 'package:hanabudget/pages/budget_creator.dart';
import 'package:provider/provider.dart';

class BudgetPage extends StatefulWidget {
  const BudgetPage({super.key});

  @override
  State<BudgetPage> createState() => _BudgetPage();
}

class _BudgetPage extends State<BudgetPage> {
  double progress(String category) {
    List<ExpenseItem> expenses =
        Provider.of<ExpenseData>(context).overallExpenseList;

    List<ExpenseItem> specificExpenses = [];

    double amount = 0.0;

    for (var i = 0; i < expenses.length; i++) {
      if (expenses[i].category == category) {
        specificExpenses.add(expenses[i]);
      }
    }

    for (ExpenseItem expense in specificExpenses) {
      amount = double.parse(expense.amount);
    }
    if (amount <= 0.0) {
      return 0.0;
    } else {
      return amount / 100;
    }
  }

  String specificTotal(String category) {
    List<ExpenseItem> expenses =
        Provider.of<ExpenseData>(context).overallExpenseList;

    List<ExpenseItem> specificExpenses = [];

    double amount = 0.0;

    for (var i = 0; i < expenses.length; i++) {
      if (expenses[i].category == category) {
        specificExpenses.add(expenses[i]);
      }
    }

    for (ExpenseItem expense in specificExpenses) {
      amount = double.parse(expense.amount);
    }

    String amountString = amount.toStringAsFixed(2);
    return amountString;
  }

  String budgetLimit(String category) {
    List<BudgetItem> budgets = Provider.of<BudgetData>(context).budgetList;
    BudgetItem specificCategory = budgets[0];
    for (var i = 0; i < budgets.length; i++) {
      if (budgets[i].category == category) {
        specificCategory = budgets[i];
      }
    }
    return specificCategory.amount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BudgetCreator()),
            );
          },
          child: const Icon(Icons.add),
          backgroundColor: const Color(0xFF1ED891),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 200),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("\tFood",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text("\$${specificTotal("Food")} / \$100\t",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              color: Colors.red,
              value: progress("Food"),
            ),
            const SizedBox(height: 30),
            // Transportation
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("\tTransportation",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text("\$${specificTotal("Transportation")} / \$100\t",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              color: Colors.red,
              value: progress("Transportation"),
            ),
            const SizedBox(height: 30),
            // Utilities
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("\tUtilities",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text("\$${specificTotal("Utilities")} / \$100\t",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              color: Colors.red,
              value: progress("Utilities"),
            ),
            const SizedBox(height: 30),
            // Entertainment
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("\tEntertainment",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text("\$${specificTotal("Entertainment")} / \$100\t",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              color: Colors.red,
              value: progress("Entertainment"),
            ),
            const SizedBox(height: 30),
            //Health
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const Text("\tHealth",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  )),
              Text("\$${specificTotal("Health")} / \$100\t",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ))
            ]),
            const SizedBox(height: 10),
            LinearProgressIndicator(
              backgroundColor: Colors.grey[300],
              color: Colors.red,
              value: progress("Health"),
            ),
            const SizedBox(height: 30),
          ],
        ));
  }
}
