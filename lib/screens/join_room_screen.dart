import 'package:flutter/material.dart';

import 'package:beacon/components/common_container.dart';
import 'package:beacon/components/custom_input.dart';

class JoinRoomScreen extends StatefulWidget {
  JoinRoomScreen({Key key}) : super(key: key);

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CommonContainer(
          heightFactor: 1.2,
          color: Colors.blueAccent,
          tag: "join",
          child: CustomInput(
            title: "ENTER THE\nROOM URL",
            textEditingController: _textEditingController,
            onTap: null,
          ),
        ),
      ),
    );
  }
}
