import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveTextField extends StatelessWidget {

  final TextInputType? keyboard;
  final String label;
  final TextEditingController titleController;
  
  AdaptiveTextField(this.keyboard,{required this.label, required this.titleController});
  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextField(
            decoration: InputDecoration(
              labelText: label,
            ),
            controller: titleController,
            keyboardType: keyboard ?? TextInputType.text,
          )
        : CupertinoTextField(
            placeholder: label,
            padding: const EdgeInsets.all(10),
            controller: titleController,
            keyboardType: keyboard ?? TextInputType.text,
          );
  }
}
