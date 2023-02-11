import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  final String text;
  final Function() handler;
  final bool filled;
  AdaptiveButton(
      {this.filled = false, required this.text, required this.handler});

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? filled
            ? ElevatedButton(
                onPressed: () {
                  handler();
                },
                child: Text(text),
              )
            : TextButton(
                onPressed: handler,
                child: Text(text),
              )
        : filled
            ? CupertinoButton.filled(
                child: Text(text),
                onPressed: () {
                  handler();
                },
              )
            : CupertinoButton(
                child: Text(text),
                onPressed: () {
                  handler();
                },
              );
  }
}
