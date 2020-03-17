import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateModalSheet extends StatelessWidget {
  const DateModalSheet({
    @required this.onChanged,
    @required this.hours,
    @required this.minutes,
    Key key,
  }) : super(key: key);

  final Function onChanged;
  final int hours;
  final int minutes;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      height: size.height / 3,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
        ),
        child: CupertinoDatePicker(
          use24hFormat: true,
          mode: CupertinoDatePickerMode.time,
          backgroundColor: Colors.black,
          initialDateTime: DateTime(1, 1, 1, hours, minutes),
          onDateTimeChanged: onChanged,
        ),
      ),
    );
  }
}
