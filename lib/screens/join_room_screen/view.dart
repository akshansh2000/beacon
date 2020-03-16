import 'package:flutter/material.dart';

import 'package:beacon/components/common_container.dart';

class JoinRoomScreen extends StatefulWidget {
  JoinRoomScreen({Key key}) : super(key: key);

  @override
  _JoinRoomScreenState createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CommonContainer(
          heightFactor: 1.2,
          color: Colors.blueAccent,
          child: null,
          tag: "join",
        ),
      ),
    );
  }
}
