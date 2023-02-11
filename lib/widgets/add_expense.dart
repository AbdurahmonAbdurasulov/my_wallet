import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:my_wallet/widgets/adaptive_button.dart';
import 'package:my_wallet/widgets/adaptive_textfield.dart';

class AddExpense extends StatefulWidget {
  final Function addNewExpense;
  AddExpense(this.addNewExpense);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  DateTime? selectedDate;
  IconData? selectedIcon;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void showNewExpenseCalendar(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: selectedDate ?? DateTime.now(),
            firstDate: DateTime(2020),
            helpText: 'Kunni tanlang !',
            cancelText: "Bekor qilish",
            confirmText: "Tanlash",
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
      ;
    });
  }

  void showExpenseIconPicker(BuildContext context) {
    FlutterIconPicker.showIconPicker(context).then((icon) {
      if (icon == null) {
        return;
      }
      setState(() {
        selectedIcon = icon;
      });
    });
  }

  void submit() {
    if (titleController.text.isEmpty ||
        amountController.text.isEmpty ||
        selectedDate == null ||
        selectedIcon == null) {
      return;
    }

    var title = titleController.text;
    var amount = double.parse(amountController.text);

    if (amount <= 0) {
      return;
    }
    widget.addNewExpense(title, amount, selectedDate, selectedIcon);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
          top: 11,
          left: 15,
          right: 15,
          bottom: MediaQuery.of(context).viewInsets.bottom > 0
              ? MediaQuery.of(context).viewInsets.bottom + 9
              : 100,
        ),
        child: Column(
          children: [
            AdaptiveTextField(null,
                label: "Xarajat nomi", titleController: titleController),
            AdaptiveTextField(TextInputType.number,
                label: "Xarajat miqdori", titleController: amountController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedDate == null
                    ? Text("Xarajat kuni tanlanmadi!")
                    : Text(
                        "Xarajat kuni:${DateFormat("dd MMMM,y").format(selectedDate!)}"),
                TextButton(
                    onPressed: () {
                      showNewExpenseCalendar(context);
                    },
                    child: Text("Kunni tanlash")),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                selectedIcon == null
                    ? Text("Icon tanlanmagan!")
                    : Row(
                        children: [
                          Text("Icon tanlandi: "),
                          Icon(selectedIcon),
                        ],
                      ),
                TextButton(
                  onPressed: () {
                    showExpenseIconPicker(context);
                  },
                  child: Text("Icon tanlash"),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdaptiveButton(
                  text: "BEKOR QILISH",
                  handler: () {
                    Navigator.of(context).pop();
                  },
                  filled: false,
                ),
                AdaptiveButton(
                  text: "KIRITISH",
                  handler: submit,
                  filled: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
