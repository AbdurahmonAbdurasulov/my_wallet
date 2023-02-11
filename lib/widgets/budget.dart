import 'package:flutter/material.dart';
import 'package:my_wallet/widgets/progress_bar.dart';
import 'edit_monthly_budget.dart';

class Budget extends StatefulWidget {
  final double totalByMonth;
  Budget(this.totalByMonth);

  @override
  State<Budget> createState() => _BudgetState();
}

class _BudgetState extends State<Budget> {
  double budgetLimit = 3000000;

  void showMonthlyBudgetWindow(BuildContext context) {
    showModalBottomSheet(
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return EditMonthlyBudget(changeBudgetLimit, budgetLimit);
        });
  }

  void changeBudgetLimit(double amount) {
    setState(() {
      budgetLimit = amount;
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalLimitPercentage = 100 * widget.totalByMonth / budgetLimit;
    totalLimitPercentage =
        totalLimitPercentage > 100 ? 100 : totalLimitPercentage;

    return LayoutBuilder(builder: (
      context,
      constraints,
    ) {
      return Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        height: constraints.maxHeight,
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 240, 250, 1),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(55),
            topRight: Radius.circular(55),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Oylik byudjet:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextButton.icon(
                        onPressed: () {
                          showMonthlyBudgetWindow(context);
                        },
                        icon: Icon(
                          Icons.edit,
                          size: 17,
                        ),
                        label: Text(
                          "${budgetLimit.toStringAsFixed(0)} so'm",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                Text(
                  "${totalLimitPercentage.toStringAsFixed(0)}%",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            ProgressBar(totalLimitPercentage),
          ],
        ),
      );
    });
  }
}
