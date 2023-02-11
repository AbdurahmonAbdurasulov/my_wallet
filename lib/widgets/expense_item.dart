import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ExpenseItem extends StatelessWidget {
  final String id;
  final String title;
  final DateTime date;
  final IconData icon;
  final double amount;
  final Key key;
  final Function deleteExpense;

  ExpenseItem(
    this.id,
    this.title,
    this.date,
    this.icon,
    this.amount,
    this.key,
    this.deleteExpense,
  ) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: key,
      onDismissed: (direction) {
        deleteExpense(id);
      },
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 15),
        color: Colors.red,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      child: ListTile(
        leading: CircleAvatar(
          child: Icon(icon),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          DateFormat("dd MMMM, y").format(date),
          style: TextStyle(fontSize: 13),
        ),
        trailing: Text(
          "$amount so'm",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
