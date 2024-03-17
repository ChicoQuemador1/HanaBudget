/*import 'package:hanabudget/models/expense_item.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveDataBase {
  // Refers box
  final _myBox = Hive.box('expense_database');

  // Writes data
  void saveData(List<ExpenseItem> allExpense) {
    List<List<dynamic>> allExpensesFormatted = [];

    for (var expense in allExpense) {
      List<dynamic> expenseFormatted = [
        expense.name,
        expense.amount,
        expense.dateTime,
      ];
      allExpensesFormatted.add(expenseFormatted);
    }

    _myBox.put("ALL_EXPENSES", allExpensesFormatted);
  }

  // Read data
  List<ExpenseItem> readData() {
    List savedExpenses = _myBox.get("ALL_EXPENSES");
    List<ExpenseItem> allExpenses = [];

    for (int i = 0; i < savedExpenses.length; i++) {
      String name = savedExpenses[i][0];
      String amount = savedExpenses[i][1];
      DateTime dateTime = savedExpenses[i][2];

      ExpenseItem expense = ExpenseItem(
        name: name,
        amount: amount,
        dateTime: dateTime,
        category:
            "SomeCategory", // Add this line. Replace "SomeCategory" with the actual category.
      );

      allExpenses.add(expense);
    }
    return allExpenses;
  }
} */
