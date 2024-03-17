import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hanabudget/pages/budget_page.dart';
import 'package:provider/provider.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/models/expense_item.dart';
import 'package:hanabudget/pages/main_page.dart';
import 'package:hanabudget/pages/graph_page.dart';
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final newExpenseNameController = TextEditingController();
  final newExpenseAmountController = TextEditingController();

  void addNewExpense() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: newExpenseNameController),
            TextField(controller: newExpenseAmountController),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: const Text('Save'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void save() {
    final newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  int _page = 0;

  Widget bodyFunction() {
    Widget currentPage;
    switch (_page) {
      case 0:
        currentPage = const MainPage();
        break;
      case 1:
        currentPage = const BudgetPage();
        break;
      case 2:
        currentPage = const GraphPage();
        break;
      default:
        currentPage = const MainPage();
    }

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200.0,
            color: const Color(0xFF1ED891),
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 20), // Adjust top padding as needed
          child: currentPage,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: addNewExpense,
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFF1ED891),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.account_balance),
              onPressed: () => setState(() => _page = 0),
            ),
            IconButton(
              icon: const Icon(Icons.account_balance_wallet_outlined),
              onPressed: () => setState(() => _page = 1),
            ),
            const SizedBox(width: 48), // Placeholder for floating action button
            IconButton(
              icon: const Icon(Icons.bar_chart_outlined),
              onPressed: () => setState(() => _page = 2),
            ),

            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () async {
                var settingsBox = await Hive.openBox('settingsBox');
                await settingsBox
                    .delete('loggedInUser'); // Clear loggedInUser key
                Navigator.pushReplacementNamed(context, '/login');
              },
            )
          ],
        ),
      ),
      body: bodyFunction(),
    );
  }
}
