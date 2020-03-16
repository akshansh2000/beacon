import 'package:flutter/material.dart';

import 'package:beacon/components/common_container.dart';
import 'package:beacon/components/prefs.dart';

class NameScreen extends StatefulWidget {
  NameScreen({this.shouldPop = true, Key key}) : super(key: key);

  final bool shouldPop;

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  TextEditingController _textEditingController;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: CommonContainer(
        heightFactor: 1.2,
        color: Colors.white,
        child: Center(
          child: Column(
            children: <Widget>[
              Spacer(flex: 2),
              Text(
                "ENTER YOUR FIRST\nNAME, PLEASE",
                textAlign: TextAlign.center,
                style: textTheme.headline,
              ),
              Spacer(flex: 3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  textAlign: TextAlign.center,
                  style: textTheme.button,
                  controller: _textEditingController,
                  cursorColor: Colors.white,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ),
              Spacer(),
              IconButton(
                  icon: Icon(
                    Icons.check,
                    size: 40,
                  ),
                  onPressed: () {
                    prefsInstance.updatePrefs(
                        "name", _textEditingController.value.text);

                    widget.shouldPop
                        ? Navigator.of(context).pop()
                        : Navigator.of(context).pushReplacementNamed("/home");
                  }),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
