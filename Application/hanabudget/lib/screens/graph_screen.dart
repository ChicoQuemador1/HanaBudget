import 'package:flutter/material.dart';
import 'package:hanabudget/components/expense_summary.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:provider/provider.dart';

class GraphPage extends StatelessWidget {
  const GraphPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, value, child) => Scaffold(
              body: ListView(children: [
                ExpenseSummary(startOfWeek: value.startOfWeekDate()),
              ]),
            ));
  }
}
