import 'package:flutter/material.dart';

import '../components/coding.dart';
import '../components/common_container.dart';
import '../components/custom_input.dart';
import '../components/custom_snackbar.dart';
import '../screens/room_screen/bloc.dart';
import '../screens/room_screen/event.dart';

class JoinRoomScreen extends StatefulWidget {
  JoinRoomScreen({Key key}) : super(key: key);

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final _textEditingController = TextEditingController();
  RegExp regex =
      RegExp("(?<=^https:\/\/app\.beacon\.cce\/)[A-Za-z0-9+\/]+={0,2}\$");
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: CommonContainer(
          color: Colors.blueAccent,
          tag: "join",
          child: CustomInput(
            title: "ENTER THE\nROOM URL",
            textEditingController: _textEditingController,
            onTap: () {
              if (!regex.hasMatch(_textEditingController.value.text))
                scaffoldKey.currentState.showSnackBar(CustomSnackbar(
                  "Please enter a valid URL.",
                  scaffoldKey.currentState,
                ));
              else {
                bloc.roomId =
                    decodeIdFromUrl(_textEditingController.value.text);
                bloc.input.add(JoinRoom());

                Navigator.of(context).pushNamed("/room");
              }
            },
          ),
        ),
      ),
    );
  }
}
