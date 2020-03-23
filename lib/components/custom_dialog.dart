import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/prefs.dart';
import '../screens/room_screen/bloc.dart';
import '../screens/room_screen/event.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog(this.text, {Key key}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text(text),
      actions: <Widget>[
        FlatButton(
          child: Text("NO"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FlatButton(
          child: Text(
            "YES",
            style: TextStyle(
              color: Colors.redAccent,
            ),
          ),
          onPressed: () {
            bloc.roomDetails[prefsInstance.prefs.getString("id")]["mode"] ==
                    "host"
                ? bloc.input.add(DeleteRoom())
                : null;

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
