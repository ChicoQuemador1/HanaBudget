import 'package:flutter/material.dart';
import 'package:hanabudget/bar_graph/bar_graph.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:provider/provider.dart';

class ExpenseSummary extends StatelessWidget {
  final DateTime startOfWeek;
  const ExpenseSummary({super.key, required this.startOfWeek});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
      builder: (context, value, child) => SizedBox(
          height: 200,
          child: MyBarGraph(
              maxY: 100,
              sunAmount: 20,
              monAmount: 50,
              tueAmount: 30,
              wedAmount: 40,
              thuAmount: 50,
              friAmount: 60,
              satAmount: 70)),
    );
  }
}
