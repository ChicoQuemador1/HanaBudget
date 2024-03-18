import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hanabudget/components/my_button_save.dart';
import 'package:hanabudget/data/budget_data.dart';
import 'package:hanabudget/models/budget_item.dart';
import 'package:provider/provider.dart';

class BudgetCreator extends StatefulWidget {
  const BudgetCreator({Key? key}) : super(key: key);

  @override
  State<BudgetCreator> createState() => _BudgetCreatorState();
}

class _BudgetCreatorState extends State<BudgetCreator> {
  TextEditingController amountController = TextEditingController();

  String? selectedCategory;

  final List<String> categories = [
    'Food',
    'Transport',
    'Utilities',
    'Entertainment',
    'Health'
  ];

  void _saveExpense(BuildContext context) {
    final newBudget = BudgetItem(
      amount: amountController.text,
      category: selectedCategory ?? 'Other',
    );
    Provider.of<BudgetData>(context, listen: false).addNewBudget(newBudget);
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Budget',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: amountController,
              decoration: InputDecoration(
                labelText: 'Budget Limit',
                prefixIcon: const Icon(
                  FontAwesomeIcons.dollarSign,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedCategory,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  FontAwesomeIcons.list, // Always using list icon
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              hint: const Text('Select Category'),
              onChanged: (String? newValue) {
                setState(() {
                  selectedCategory = newValue;
                });
              },
              items: categories.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 30),
            MyButtonSave(onTap: () => _saveExpense(context)),
          ],
        ),
      ),
    );
  }
}
