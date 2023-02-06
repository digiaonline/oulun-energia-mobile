import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/app.dart';

void showSnackbar(String text) {
  var snackBar = SnackBar(
      content: Text(
    text,
  ));
  WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => messengerKey.currentState?.showSnackBar(snackBar));
}
