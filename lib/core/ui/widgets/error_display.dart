import 'dart:developer';

import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class ErrorDisplayFlushbar {
  void showErrorFlushbar(BuildContext context, String error) {
    Flushbar(
      title: "Fehler:",
      message: error,
      icon: Icon(
        Icons.error,
        size: 28,
        color: Colors.red,
      ),
      duration: Duration(seconds: 5),
      isDismissible: true,
      leftBarIndicatorColor: Colors.red,
    )..show(context);
  }
}
