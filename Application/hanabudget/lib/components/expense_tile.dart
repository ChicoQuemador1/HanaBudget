import 'package:flutter/material.dart';

class ExpenseTile extends StatelessWidget {
  final String name;
  final String amount;
  final DateTime dateTime;
  final String category; // Ensure this is added if not already

  const ExpenseTile({
    super.key,
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.category,
  });

  IconData getIconForCategory(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Transport':
        return Icons.directions_bus;
      case 'Utilities':
        return Icons.lightbulb;
      case 'Entertainment':
        return Icons.movie;
      case 'Health':
        return Icons.local_hospital;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(getIconForCategory(category)), // Use the dynamic icon
      title: Text(name),
      subtitle: Text('${dateTime.day}/${dateTime.month}/${dateTime.year}'),
      trailing: Text('\$' + amount),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
  }
}
