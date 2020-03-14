import 'package:flutter/material.dart';

import 'package:beacon/common_screen.dart';

class DurationScreen extends StatefulWidget {
  DurationScreen({Key key}) : super(key: key);

  @override
  _DurationScreenState createState() => _DurationScreenState();
}

class _DurationScreenState extends State<DurationScreen> {
  double duration = 0.25;
  List<double> durationsList = [0.25, 0.5, 1, 2, 3, 6, 8];

  @override
  Widget build(BuildContext context) {
    return CommonScreen(
      tag: "host",
      color: Colors.blueAccent,
      shouldShowDialog: false,
      heightFactor: 1.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            "SET A\nDURATION",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              decoration: TextDecoration.none,
              color: Colors.white,
              fontFamily: "Roboto",
            ),
          ),
          Column(
            children: <Widget>[
              Material(
                color: Colors.transparent,
                child: DropdownButton(
                  value: duration,
                  items: durationsList.map((item) {
                    return DropdownMenuItem(
                      child: item < 1
                          ? Text((item * 60).toInt().toString() + " minutes")
                          : item == 1
                              ? Text(item.toInt().toString() + " hour")
                              : Text(item.toInt().toString() + " hours"),
                      value: item,
                    );
                  }).toList(),
                  onChanged: (newDuration) {
                    setState(() {
                      duration = newDuration;
                    });
                  },
                ),
              ),
              SizedBox(height: 100),
              Material(
                color: Colors.transparent,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  iconSize: 26,
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/host'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
