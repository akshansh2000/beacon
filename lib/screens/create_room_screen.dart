import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:beacon/components/common_container.dart';
import 'package:beacon/components/custom_input.dart';
import 'package:beacon/components/date_modal_sheet.dart';

class CreateRoomScreen extends StatefulWidget {
  CreateRoomScreen({Key key}) : super(key: key);

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _textEditingController = TextEditingController();
  int hours = 3, minutes = 0;

  @override
  void initState() {
    super.initState();
    _textEditingController.text = intDurationToString(hours, minutes);
  }

  intDurationToString(int hours, int minutes) {
    return hours.toString() +
        "h " +
        (minutes < 10 ? '0' : "") +
        minutes.toString() +
        'm';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CommonContainer(
          color: Colors.redAccent,
          child: CustomInput(
            title: "DURATION",
            textEditingController: _textEditingController,
            isReadOnly: true,
            onFieldTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) {
                  return DateModalSheet(
                    onChanged: (dateTime) {
                      setState(() {
                        hours = dateTime.hour;
                        minutes = dateTime.minute;
                        _textEditingController.text =
                            intDurationToString(hours, minutes);
                      });
                    },
                    hours: hours,
                    minutes: minutes,
                  );
                },
              );
            },
            onTap: () {},
          ),
          tag: "create",
        ),
      ),
    );
  }
}
