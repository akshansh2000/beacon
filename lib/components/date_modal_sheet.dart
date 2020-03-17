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
      color: Colors.grey[900],
      child: CupertinoTheme(
        data: CupertinoThemeData(
          brightness: Brightness.dark,
        ),
        child: CupertinoTimerPicker(
          alignment: Alignment.center,
          backgroundColor: Colors.grey[900],
          onTimerDurationChanged: onChanged,
          mode: CupertinoTimerPickerMode.hm,
          initialTimerDuration: Duration(
            hours: hours,
            minutes: minutes,
          ),
        ),
      ),
    );
  }
}
