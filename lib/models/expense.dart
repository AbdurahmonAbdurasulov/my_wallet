import 'package:flutter/material.dart';

class Expense {
  final String id;
  final String title;
  final DateTime date;
  final double amount;
  final IconData icon;

  Expense({
    required this.id,
    required this.title,
    required this.date,
    required this.amount,
    this.icon = Icons.ac_unit,
  });
}

class Expenses {
  List<Expense> _items = [
    Expense(
      id: "e1",
      title: "Tarvuz",
      date: DateTime.now(),
      amount: 20000,
    ),
    Expense(
      id: "e2",
      title: "Kitob",
      date: DateTime.now(),
      amount: 35000,
    ),
    Expense(
      id: "e3",
      title: "Komputer",
      date: DateTime.now(),
      amount: 2500000,
    ),
    Expense(
      id: "e4",
      title: "Telefon",
      date: DateTime.now(),
      amount: 2000000,
    ),
  ];

  List<Expense> get items {
    return _items;
  }

  List<Expense> itemsByMonth(DateTime date) {
    return _items
        .where((expense) =>
            expense.date.month == date.month && expense.date.year == date.year)
        .toList();
  }

  double totalExpensesByMonth(DateTime date) {
    final expensesByMonth = itemsByMonth(date);

    return expensesByMonth.fold(0, (previousValue, expense) {
      return previousValue + expense.amount;
    });
  }

  void addNewExpense(
      String title, double amount, DateTime date, IconData icon) {
    _items.add(Expense(
      id: "e${_items.length + 1}",
      title: title,
      amount: amount,
      date: date,
      icon: icon,
    ));
  }

  void delete(String id) {
    _items.removeWhere((expense) => expense.id == id);
  }
}
