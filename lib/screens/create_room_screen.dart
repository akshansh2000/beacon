import 'package:flutter/material.dart';

import 'package:beacon/components/common_container.dart';

class CreateRoomScreen extends StatefulWidget {
  CreateRoomScreen({Key key}) : super(key: key);

  @override
  _CreateRoomScreenState createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CommonContainer(
          color: Colors.redAccent,
          child: null,
          tag: "create",
        ),
      ),
    );
  }
}
