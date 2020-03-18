import 'package:flutter/material.dart';

import 'package:beacon/components/common_container.dart';
import 'package:beacon/components/custom_input.dart';
import 'package:beacon/components/custom_snackbar.dart';
import 'package:beacon/components/prefs.dart';

import 'package:random_string/random_string.dart';

class NameScreen extends StatefulWidget {
  NameScreen({this.shouldPop = true, Key key}) : super(key: key);

  final bool shouldPop;

  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _textEditingController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _textEditingController.text = prefsInstance.prefs.getString("name") ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Center(
        child: CommonContainer(
          color: Colors.white,
          child: CustomInput(
            title: "ENTER YOUR\nFIRST AND LAST NAME,\nPLEASE",
            textEditingController: _textEditingController,
            onTap: () {
              prefsInstance.updatePrefs(
                  "name", _textEditingController.value.text);

              prefsInstance.updatePrefs("id", randomAlphaNumeric(20));

              _textEditingController.value.text.isEmpty
                  ? scaffoldKey.currentState.showSnackBar(
                      CustomSnackbar(
                        "Please enter a valid name.",
                        scaffoldKey.currentState,
                      ),
                    )
                  : widget.shouldPop
                      ? Navigator.of(context).pop()
                      : Navigator.of(context).pushReplacementNamed("/home");
            },
          ),
        ),
      ),
    );
  }
}
