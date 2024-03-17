import 'package:flutter/material.dart';
import 'package:hanabudget/components/expense_tile.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/models/expense_item.dart';
import 'package:hive/hive.dart';
import 'package:hanabudget/screens/main_page.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:provider/provider.dart';

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
        title: Text('Add new expense'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Expense Name
            TextField(controller: newExpenseNameController),
            // Expense Amount
            TextField(
              controller: newExpenseAmountController,
            ),
          ],
        ),
        actions: [
          // Save Button
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: cancel,
            child: Text('Cancel'),
          )
        ],
      ),
    );
  }

  void save() {
    ExpenseItem newExpense = ExpenseItem(
      name: newExpenseNameController.text,
      amount: newExpenseAmountController.text,
      dateTime: DateTime.now(),
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newExpenseNameController.clear();
    newExpenseAmountController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Consumer<ExpenseData>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: addNewExpense,
          child: Icon(Icons.add),
          backgroundColor: Color(0xFF1ED891),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 6.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.account_balance),
                onPressed: () {
                  MainScreen();
                },
              ),
              IconButton(
                icon: Icon(Icons.account_balance_wallet_outlined),
                onPressed: () {},
              ),
              SizedBox(
                  width: 48), // The empty space for the floating action button
              IconButton(
                icon: Icon(Icons.bar_chart_outlined),
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  var settingsBox = await Hive.openBox('settingsBox');
                  await settingsBox.delete('loggedInUser');
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
          ),
        ),
        body: ListView.builder(
            itemCount: value.getAllExpenseList().length,
            itemBuilder: (context, index) => ExpenseTile(
                name: value.getAllExpenseList()[index].name,
                amount: value.getAllExpenseList()[index].amount,
                dateTime: value.getAllExpenseList()[index].dateTime)),

        /*
        body: Stack(
          children: [
            Column(
              children: [
                ClipPath(
                  clipper: OvalBottomBorderClipper(),
                  child: Container(
                    width: size.width,
                    height: size.height * 0.20,
                    color: Color(0xFF1ED891),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child:
                        const MainScreen(), // Positioned on top of the Column
                  ),
                ),
                SizedBox(height: 20),
                ListView.builder(
                    itemCount: value.getAllExpenseList().length,
                    itemBuilder: (context, index) => ListTile(
                        title: Text(value.getAllExpenseList()[index].name)))
              ],
            ),
          ],
        ),
        */
      ),
    );
  }
}
