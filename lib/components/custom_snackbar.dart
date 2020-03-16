import 'package:flutter/material.dart';

SnackBar CustomSnackbar(String text, ScaffoldState scaffoldState) {
  return SnackBar(
    backgroundColor: Colors.grey[900],
    content: Text(
      text,
      style: TextStyle(
        color: Colors.white,
      ),
    ),
    action: SnackBarAction(
      label: "Okay",
      onPressed: () => scaffoldState.hideCurrentSnackBar(),
      textColor: Colors.amberAccent,
    ),
  );
}
