import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Header extends StatelessWidget {
  final Function showCalendar;
  final DateTime selectedDate;
  final Function() previousMonth;
  final Function() nextMonth;
  final double totalByMonth;

  Header(this.totalByMonth,
      this.showCalendar, this.selectedDate, this.previousMonth, this.nextMonth);

  @override
  Widget build(BuildContext context) {
    final isLastDate = selectedDate.year == DateTime.now().year &&
        selectedDate.month == DateTime.now().month;
    final isFirstDate = selectedDate.year == 2020 && selectedDate.month == 1;

    return Padding(
      padding: const EdgeInsets.all(21.0),
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                showCalendar(context);
              },
              child: Text(
                DateFormat("MMMM, yyyy").format(selectedDate),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: previousMonth,
                  icon: Icon(
                    Icons.arrow_left,
                    size: 30,
                    color: isFirstDate ? Colors.grey : Colors.green,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2,
                      color: isFirstDate ? Colors.grey : Colors.green),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    totalByMonth.toStringAsFixed(0),
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "so'm",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      height: 0.7,
                    ),
                  ),
                ],
              ),
              Container(
                width: 40,
                height: 40,
                child: IconButton(
                  padding: const EdgeInsets.all(0),
                  onPressed: nextMonth,
                  icon: Icon(
                    Icons.arrow_right,
                    size: 30,
                    color: isLastDate ? Colors.grey : Colors.green,
                  ),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                      width: 2, color: isLastDate ? Colors.grey : Colors.green),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
