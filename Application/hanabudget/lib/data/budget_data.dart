import 'package:flutter/material.dart';
import 'package:hanabudget/models/budget_item.dart';

class BudgetData extends ChangeNotifier {
  // list all Expenses
  List<BudgetItem> budgetList = [];
  // Get Expense List
  List<BudgetItem> getBudgetList() {
    return budgetList;
  }

  // Add New Expense
  void addNewBudget(BudgetItem item) {
    budgetList.add(item);
    notifyListeners();
  }

  // Remove Expense
  void deleteBudget(BudgetItem item) {
    budgetList.remove(item);
    notifyListeners();
  }
}
