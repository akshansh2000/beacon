import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../components/common_container.dart';
import '../components/custom_input.dart';
import '../components/custom_snackbar.dart';
import '../components/date_modal_sheet.dart';
import '../components/prefs.dart';
import '../screens/room_screen/bloc.dart';
import '../screens/room_screen/event.dart';

class CreateRoomScreen extends StatefulWidget {
  CreateRoomScreen({Key key}) : super(key: key);

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _textEditingController = TextEditingController();
  int hours = 3, minutes = 0;
  final scaffoldKey = GlobalKey<ScaffoldState>();

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
      key: scaffoldKey,
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
                    onChanged: (Duration duration) {
                      setState(() {
                        hours = duration.inHours;
                        minutes = duration.inMinutes - (duration.inHours * 60);
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
            onTap: () {
              if (hours == 0 && minutes < 15)
                scaffoldKey.currentState.showSnackBar(
                  CustomSnackbar(
                    "The duration of a room cannot be less than 15 minutes.",
                    scaffoldKey.currentState,
                  ),
                );
              else {
                final now = DateTime.now();
                prefsInstance.updatePrefs(
                  "expiry",
                  now
                      .add(
                        Duration(
                          hours: hours,
                          minutes: minutes,
                        ),
                      )
                      .toString(),
                );

                bloc.input.add(CreateRoom());
                Navigator.of(context).pushNamed("/room");
              }
            },
          ),
          tag: "create",
        ),
      ),
    );
  }
}
