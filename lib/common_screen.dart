import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

GlobalKey<ScaffoldState> scaffoldState;

class CommonScreen extends StatefulWidget {
  CommonScreen({
    Key key,
    @required this.color,
    @required this.tag,
    @required this.child,
    this.shouldExit = false,
    this.shouldShowDialog = true,
  }) : super(key: key);

  final Color color;
  final String tag;
  final Widget child;
  final bool shouldExit;
  final bool shouldShowDialog;

  @override
  _CommonScreenState createState() => _CommonScreenState();
}

class _CommonScreenState extends State<CommonScreen> {
  Size size;

  _CommonScreenState() {
    scaffoldState = GlobalKey<ScaffoldState>();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      key: scaffoldState,
      body: Stack(
        children: <Widget>[
          Center(
            child: Hero(
              tag: widget.tag,
              child: Container(
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: size.width / 1.1,
                height: size.height / 1.2,
                child: widget.child,
              ),
            ),
          ),
          if (widget.tag != "null")
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => widget.shouldShowDialog
                      ? showWarning(
                          context,
                          widget.tag,
                          shouldExit: widget.shouldExit,
                        )
                      : Navigator.of(context).pop(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

showWarning(context, tag, {bool shouldExit = false}) {
  showDialog(
    context: context,
    child: AlertDialog(
      backgroundColor: Colors.grey[900],
      title: Text("Are you sure?"),
      content: Text(
        tag == "host"
            ? "Your friends will no longer be able to track you. Still exit?"
            : "You will no longer be able to track your friend. Still exit?",
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text("No"),
        ),
        FlatButton(
          onPressed: () {
            if (shouldExit)
              SystemChannels.platform.invokeMethod("SystemNavigator.pop");

            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text("Yes"),
        ),
      ],
    ),
  );
}
