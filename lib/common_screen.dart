import 'package:flutter/material.dart';

GlobalKey<ScaffoldState> scaffoldState;

class CommonScreen extends StatefulWidget {
  CommonScreen({
    Key key,
    @required this.color,
    @required this.tag,
    @required this.child,
  }) : super(key: key);

  final Color color;
  final String tag;
  final Widget child;

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
                  onPressed: () => showWarning(context, widget.tag),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

showWarning(context, tag) {
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
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          },
          child: Text("Yes"),
        ),
      ],
    ),
  );
}
