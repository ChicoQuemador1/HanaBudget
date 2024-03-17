import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:hanabudget/components/expense_tile.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/models/expense_item.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:hanabudget/models/user.dart';
import 'package:hanabudget/screens/main_page.dart';

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
            TextField(controller: newExpenseNameController),
            TextField(controller: newExpenseAmountController),
          ],
        ),
        actions: [
          MaterialButton(
            onPressed: save,
            child: Text('Save'),
          ),
          MaterialButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
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

  @override
  Widget build(BuildContext context) {
    return Consumer<ExpenseData>(
        builder: (context, expenseData, child) => Scaffold(
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton(
                onPressed: addNewExpense,
                child: Icon(Icons.add),
                backgroundColor: Color(0xFF1ED891),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: BottomAppBar(
                shape: CircularNotchedRectangle(),
                notchMargin: 6.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: Icon(Icons.account_balance),
                      onPressed: () async {
                        var settingsBox = await Hive.openBox('settingsBox');
                        var loggedInUsername =
                            settingsBox.get('loggedInUser', defaultValue: '');
                        if (loggedInUsername != '') {
                          var userBox = Hive.box<User>('userBox');
                          var user = userBox.get(loggedInUsername);
                          /*
                          showModalBottomSheet(
                              context: context,
                              builder: (context) => user != null
                                  ? userMainScreen(user.firstName)
                                  : userMainScreen('User'));
                                  */
                        }
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.account_balance_wallet_outlined),
                      onPressed: () {},
                    ),
                    SizedBox(
                        width: 48), // Placeholder for floating action button
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
              body: MainPage(),
            ));
    /*
        Stack(
          children: [
            ClipPath(
              clipper: OvalBottomBorderClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                color: Color(0xFF1ED891),
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.only(top: 180.0),
              child: ListView.builder(
                itemCount: expenseData.getAllExpenseList().length,
                itemBuilder: (context, index) => ExpenseTile(
                  name: expenseData.getAllExpenseList()[index].name,
                  amount: expenseData.getAllExpenseList()[index].amount,
                  dateTime: expenseData.getAllExpenseList()[index].dateTime,
                ),
              ),
            ),
            
          ],
        ),*/
  }
}
