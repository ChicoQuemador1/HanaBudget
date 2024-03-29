import 'package:flutter/material.dart';
import 'package:hanabudget/datetime/date_time_helper.dart';
import 'package:hanabudget/models/expense_item.dart';

class ExpenseData extends ChangeNotifier {
  // list all Expenses
  List<ExpenseItem> overallExpenseList = [];
  // Get Expense List
  List<ExpenseItem> getAllExpenseList() {
    return overallExpenseList;
  }

  // Add New Expense
  void addNewExpense(ExpenseItem item) {
    overallExpenseList.add(item);
    notifyListeners();
  }

  // Remove Expense
  void deleteExpense(ExpenseItem item) {
    overallExpenseList.remove(item);
    notifyListeners();
  }

  // Get Weekday from dateTime obj
  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return "Monday";
      case 2:
        return "Tuesday";
      case 3:
        return "Wednesday";
      case 4:
        return "Thursday";
      case 5:
        return "Friday";
      case 6:
        return "Saturday";
      case 7:
        return "Sunday";
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();
    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sunday') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }
    return startOfWeek!;
  }

  Map<String, double> calculateDailyExpense() {
    Map<String, double> dailyExpense = {};

    for (var expense in overallExpenseList) {
      String date = convertDateTimeToString(expense.dateTime);
      double amount = double.parse(expense.amount);

      if (dailyExpense.containsKey(date)) {
        double currentAmount = dailyExpense[date]!;
        currentAmount += amount;
        dailyExpense[date] = currentAmount;
      } else {
        dailyExpense.addAll({date: amount});
      }
    }
    return dailyExpense;
  }
}
