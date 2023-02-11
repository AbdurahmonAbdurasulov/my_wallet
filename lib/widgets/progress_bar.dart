import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double totalLimitPercentage;
  ProgressBar(this.totalLimitPercentage);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        height: 5,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Color.fromRGBO(212, 219, 239, 1),
        ),
        child: FractionallySizedBox(
          heightFactor: 2,
          widthFactor: totalLimitPercentage/100,
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.amber,
                  Colors.amber.shade100,
                  Colors.amber,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber,
                  blurRadius: 10,
                  spreadRadius: -5,
                )
              ],
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ));
  }
}
