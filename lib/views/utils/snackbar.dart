import 'package:flutter/material.dart';
import 'package:oulun_energia_mobile/app.dart';

void showSnackbar(String text, {SnackBarAction? action}) {
  var snackBar = SnackBar(
      action: action,
      content: Text(
        text,
      ));
  WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) => messengerKey.currentState?.showSnackBar(snackBar));
}
