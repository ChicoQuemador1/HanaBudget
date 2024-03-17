class ExpenseItem {
  final String name;
  final String amount;
  final DateTime dateTime;
  final String category; // Add this line

  ExpenseItem({
    required this.name,
    required this.amount,
    required this.dateTime,
    required this.category, // Add this line
  });
}
