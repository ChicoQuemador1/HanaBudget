import 'package:flutter/material.dart';
import 'package:hanabudget/components/my_button_save.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:hanabudget/data/expense_data.dart';
import 'package:hanabudget/models/expense_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // FontAwesomeIcons package imported

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  TextEditingController expenseController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String? selectedCategory;

  final List<String> categories = ['Food', 'Transport', 'Utilities'];

  @override
  void initState() {
    super.initState();
    dateController.text = DateFormat('dd/MM/yyyy').format(DateTime.now());
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('dd/MM/yyyy').format(picked);
      });
    }
  }

  void _saveExpense(BuildContext context) {
    final newExpense = ExpenseItem(
      name: expenseController.text,
      amount: expenseController.text,
      dateTime: selectedDate,
    );
    Provider.of<ExpenseData>(context, listen: false).addNewExpense(newExpense);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: expenseController,
              decoration: InputDecoration(
                labelText: 'Expense Amount',
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
            const SizedBox(height: 20),
            TextFormField(
              controller: dateController,
              decoration: InputDecoration(
                labelText: 'Date',
                prefixIcon: const Icon(
                  FontAwesomeIcons.calendarAlt,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    FontAwesomeIcons.calendarDay,
                    size: 20,
                  ),
                  onPressed: () => _selectDate(context),
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 30),
            MyButtonSave(onTap: () => _saveExpense(context)),
          ],
        ),
      ),
    );
  }
}
