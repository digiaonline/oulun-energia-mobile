import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/app.dart';

void showSnackbar(String text) {
  var snackbar = SnackBar(
      content: Text(
    text,
    style: const TextStyle(color: Colors.redAccent),
  ));
  WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => messengerKey.currentState?.showSnackBar(snackbar));
}
