import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/adaptive_button.dart';

class EditMonthlyBudget extends StatefulWidget {
  final Function changeBudgetLimit;
  final double budgetLimit;
  EditMonthlyBudget(this.changeBudgetLimit, this.budgetLimit);

  @override
  State<EditMonthlyBudget> createState() => _EditMonthlyBudgetState();
}

class _EditMonthlyBudgetState extends State<EditMonthlyBudget> {
  late TextEditingController budgetAmountController;

  @override
  void initState() {
    budgetAmountController = TextEditingController();
    budgetAmountController.text = widget.budgetLimit.toStringAsFixed(0);
    super.initState();
  }

  @override
  void dispose() {
    budgetAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: "Oylik budjetni kiriting:",
            ),
            keyboardType: TextInputType.number,
            controller: budgetAmountController,
          ),
          SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AdaptiveButton(
                text: "Bekor qilish",
                handler: () {
                  Navigator.of(context).pop();
                },
                filled: false,
              ),
              AdaptiveButton(
                text: "O'zgartirish",
                handler: () {
                  if (budgetAmountController.text.isEmpty) {
                    return;
                  }
                  final amount = double.parse(budgetAmountController.text);
                  if (amount > 0) {
                    widget.changeBudgetLimit(amount);
                    Navigator.of(context).pop();
                  }
                },
                filled: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
