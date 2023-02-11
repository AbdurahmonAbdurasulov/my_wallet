import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/expense.dart';
import './expense_item.dart';

class ExpenseList extends StatefulWidget {
  final List<Expense> expenses;
  final Function deleteExpense;
  ExpenseList(this.expenses, this.deleteExpense);

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context,constraints) {
        return Container(
          clipBehavior: Clip.hardEdge,
          width: MediaQuery.of(context).size.width,
          height: constraints.maxHeight-88,
          margin: const EdgeInsets.only(top: 88),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(55),
                topRight: Radius.circular(55),
              )),
          child: widget.expenses.length > 0
              ? ListView.builder(
                  padding: const EdgeInsets.only(
                    top: 10,
                    right: 7,
                  ),
                  itemBuilder: ((context, i) {
                    return ExpenseItem(
                      widget.expenses[i].id,
                      widget.expenses[i].title,
                      widget.expenses[i].date,
                      widget.expenses[i].icon,
                      widget.expenses[i].amount,                  
                      ValueKey(widget.expenses[i].id),
                      widget.deleteExpense,
                      
                    );
                  }),
                  itemCount: widget.expenses.length,
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      "Xarajatlar yo'q",
                      style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    Image.asset(
                      "assets/images/404-error.png",
                      fit: BoxFit.cover,
                      width: 250,
                    ),
                  ],
                ),
        );
      }
    );
  }
}
