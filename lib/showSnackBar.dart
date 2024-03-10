import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String text, {int durationInSeconds = 4}) {
  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      duration: Duration(seconds: durationInSeconds),
    ),
  );
}
