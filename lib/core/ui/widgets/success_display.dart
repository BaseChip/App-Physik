import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class SuccessDisplayFlushbar {
  void showSuccessFlushbar(BuildContext context, String success) {
    Flushbar(
      title: "Erfolgreich:",
      message: success,
      icon: Icon(
        Icons.check,
        size: 28,
        color: Colors.green,
      ),
      duration: Duration(seconds: 5),
      isDismissible: true,
      leftBarIndicatorColor: Colors.green,
    )..show(context);
  }
}
