import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_wallet/widgets/body.dart';
import './widgets/header.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import './models/expense.dart';
import './widgets/add_expense.dart';

void main(List<String> args) {
  //Ekrani aylanmidon atish
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        accentColor: Colors.amber,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: MyWallet(),
    );
  }
}

class MyWallet extends StatefulWidget {
  @override
  State<MyWallet> createState() => _MyWalletState();
}

class _MyWalletState extends State<MyWallet> {
  Expenses expenseData = Expenses();
  DateTime selectedDate = DateTime.now();
  bool showExpenseList = false;

  void showCalendar(BuildContext context) {
    showMonthPicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2023),
    ).then((value) {
      if (value != null) {
        setState(() {
          selectedDate = value;
        });
      }
    });
  }

  void previousMonth() {
    setState(() {
      if (selectedDate.year == 2020 && selectedDate.month == 1) {
        return;
      }
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month - 1,
        selectedDate.day,
      );
    });
  }

  void nextMonth() {
    setState(() {
      if (selectedDate.year == DateTime.now().year &&
          selectedDate.month == DateTime.now().month) {
        return;
      }
      selectedDate = DateTime(
        selectedDate.year,
        selectedDate.month + 1,
        selectedDate.day,
      );
    });
  }

  void showAddExpenseWindow(BuildContext context) {
    showModalBottomSheet(
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (ctx) {
          return AddExpense(addNewExpense);
        });
  }

  void addNewExpense(
    String title,
    double amount,
    DateTime date,
    IconData icon,
  ) {
    setState(() {
      expenseData.addNewExpense(title, amount, date, icon);
    });
  }

  void deleteExpense(String id) {
    setState(() {
      expenseData.delete(id);
    });
  }

  Widget showPortraitItems(totalByMonth, deviceHeight, deviceWidth) {
    return Column(
      children: [
        Container(
          height: deviceHeight * 0.25,
          width: deviceWidth,
          child: Header(
            totalByMonth,
            showCalendar,
            selectedDate,
            previousMonth,
            nextMonth,
          ),
        ),
        Container(
          height: deviceHeight * 0.75,
          width: deviceWidth,
          child: Body(
            expenseData.itemsByMonth(selectedDate),
            totalByMonth,
            deleteExpense,
          ),
        ),
      ],
    );
  }

  Widget showLandscapeItems(totalByMonth, deviceHeight, deviceWidth) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ro'yhatni ko'rsatish:"),
            Switch.adaptive(
              value: showExpenseList,
              onChanged: (value) {
                setState(() {
                  showExpenseList = value;
                });
              },
            ),
          ],
        ),
        showExpenseList
            ? Container(
                height: deviceHeight * 0.85,
                width: deviceWidth,
                child: Body(
                  expenseData.itemsByMonth(selectedDate),
                  totalByMonth,
                  deleteExpense,
                ),
              )
            : Container(
                height: deviceHeight * 0.85,
                width: deviceWidth,
                child: Header(
                  totalByMonth,
                  showCalendar,
                  selectedDate,
                  previousMonth,
                  nextMonth,
                ),
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalByMonth = expenseData.totalExpensesByMonth(selectedDate);
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("My Wallet"),
      actions: Platform.isIOS
          ? [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.add),
              )
            ]
          : [],
    );
    final topPadding = MediaQuery.of(context).padding.top;
    final deviceHeight = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        topPadding;
    final deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: [
            isLandscape
                ? showLandscapeItems(totalByMonth, deviceHeight, deviceWidth)
                : showPortraitItems(totalByMonth, deviceHeight, deviceWidth),
          ],
        ),
      ),
      floatingActionButton: Platform.isAndroid
          ? FloatingActionButton(
              onPressed: () {
                showAddExpenseWindow(context);
              },
              child: Icon(Icons.add),
            )
          : Container(),
    );
  }
}
